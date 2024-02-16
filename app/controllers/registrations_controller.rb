class RegistrationsController < Devise::RegistrationsController

  def new
    if params[:token]
      invite = Invite.find_by_token(params[:token])

      if invite.invitee_id == nil
        @invite = invite
      end
    end

    super
  end
  
  def create
    @invite = Invite.find_by_token(params[:user][:token])

    if @invite
      user = User.new(user_params)

      if user.save
        if @invite.update(invitee_id: user.id)
          yield user if block_given?

          if user.persisted?
            if user.active_for_authentication?
              set_flash_message! :notice, :signed_up
              sign_up('user', user)
              respond_with user, location: after_sign_up_path_for(user)
            else
              set_flash_message! :notice, :"signed_up_but_#{user.inactive_message}"
              expire_data_after_sign_in!
              respond_with user, location: after_inactive_sign_up_path_for(user)
            end
          else
            clean_up_passwords user
            set_minimum_password_length
            respond_with user
          end
        end
      end
    else
      super
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation).merge(email: @invite.email)
    end

end