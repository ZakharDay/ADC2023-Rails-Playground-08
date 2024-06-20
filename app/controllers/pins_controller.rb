class PinsController < ApplicationController
  load_and_authorize_resource
  before_action :set_pin, only: %i[ show edit update destroy toggle_favourite ]

  # GET /pins or /pins.json
  def index
    @pins = Pin.all

    # META
    @title = "Пины"
    # 
  end

  def by_tag
    @pins = Pin.tagged_with(params[:tag])
    render :index
  end

  # GET /pins/1 or /pins/1.json
  def show
  end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins or /pins.json
  def create
    @pin = Pin.new(pin_params)

    respond_to do |format|
      if @pin.save
        # WaitAndMakeJob.perform_later(@pin, current_user)
        Resque.enqueue_at(15.seconds.from_now, WaitAndMakeJob, @pin, current_user)

        format.html { redirect_to pin_url(@pin), notice: "Pin was successfully created." }
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1 or /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to pin_url(@pin), notice: "Pin was successfully updated." }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1 or /pins/1.json
  def destroy
    @pin.destroy

    respond_to do |format|
      format.html { redirect_to pins_url, notice: "Pin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_favourite
    pin_user_ids = []

    @pin.users_who_favourited.each do |user|
      pin_user_ids << user.id
    end

    if pin_user_ids.include?(current_user.id)
      current_user.pins_i_favourited.delete(@pin)
    else
      current_user.pins_i_favourited << @pin
    end

    set_pin
  end

  def toggle_like
    pin_user_ids = []

    @pin.users_who_liked.each do |user|
      pin_user_ids << user.id
    end

    if pin_user_ids.include?(current_user.id)
      current_user.pins_i_liked.delete(@pin)
    else
      current_user.pins_i_liked << @pin
    end

    set_pin

    ActionCable.server.broadcast("pins_channel", { id: @pin.id, likes: @pin.likes.count })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pin_params
      params.require(:pin).permit(:title, :description, :pin_image, :tag_list, :category_list).merge(user_id: current_user.id)
    end
end
