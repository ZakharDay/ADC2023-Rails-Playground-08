class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]

  def show
    @invites = @profile.user.invites.left
    @invites_left = @invites.count
    @invite = @invites.first
    @favourites = @profile.user.favourites
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:username, :about)
    end
end
