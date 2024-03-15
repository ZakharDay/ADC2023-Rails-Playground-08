class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_pin, only: %i[ create edit ]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    if current_user
      @comment = @pin.comments.new(comment_params)
      # @comment = @pin.comments.new(body: params[:comment][:body], user_id: current_user.id)

      respond_to do |format|
        if @comment.save
          # @pin = @comment.pin
          # format.turbo_stream { render turbo_stream: turbo_stream.prepend('comments', partial: 'comment', locals: {pin: @pin}) }

          if @comment.user.id != @pin.user.id
            user = @pin.user
            notification = user.notifications.create!(body: "Комментарий '#{@comment.body}' от пользователя #{@comment.user.email}")
          end

          format.html { redirect_to pin_url(@pin), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_registration_path, notice: "You need to log in or register" }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to pin_url(@comment.pin), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pin = @comment.pin
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to pin_url(@pin), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_pin
      @pin = Pin.friendly.find(params[:pin_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      if current_user
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
      else
        params.require(:comment).permit(:body)
      end
    end
end
