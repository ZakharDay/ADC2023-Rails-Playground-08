class PolyCommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment, only: %i[ show edit update destroy ]

  def edit
  end

  def create
    if current_user
      @poly_comment = PolyComment.new(poly_comment_params)

      respond_to do |format|
        if @poly_comment.save
          format.html { redirect_back fallback_location: root_path, notice: "Comment was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_registration_path, notice: "You need to log in or register" }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @comment.update(comment_params)
  #       format.html { redirect_to pin_url(@comment.pin), notice: "Comment was successfully updated." }
  #       format.json { render :show, status: :ok, location: @comment }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @pin = @comment.pin
  #   @comment.destroy

  #   respond_to do |format|
  #     format.html { redirect_to pin_url(@pin), notice: "Comment was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_comment
    #   @comment = Comment.find(params[:id])
    # end

    # def set_pin
    #   @pin = Pin.find(params[:pin_id])
    # end

    # Only allow a list of trusted parameters through.
    def poly_comment_params
      if current_user
        params.require(:poly_comment).permit(:body, :commentable_type, :commentable_id).merge(user_id: current_user.id)
      else
        params.require(:poly_comment).permit(:body, :commentable_type, :commentable_id)
      end
    end
end
