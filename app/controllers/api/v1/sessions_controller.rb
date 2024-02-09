class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  skip_before_action :verify_signed_out_user, only: [:destroy]

  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user

      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        user: @user
      }, status: :ok
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  def destroy
    # jti = request.headers["Authorization"]
    
    # Rails.logger.info "====================="
    # Rails.logger.info jti
    # Rails.logger.info "====================="

    # jwt_payload = JWT.decode(jti, Rails.application.credentials.devise_jwt_secret_key!)

    # Rails.logger.info jwt_payload
    # puts = jwt_payload['sub']
    # puts = "====================="

    jti = request.headers["Authorization"]
    user = User.find_by_jti(jti)

    if user && user.update_column(:jti, SecureRandom.uuid)
      render json: {
        messages: "Signed Out Successfully",
        is_success: true,
        data: {}
      }, status: :ok
    else
      render json: {
        messages: "Signed Out Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  private

    def sign_in_params
      params.require(:user).permit :email, :password
    end

    def load_user
      @user = User.find_for_database_authentication(email: sign_in_params[:email])

      if @user
        return @user
      else
        render json: {
          messages: "Cannot get User",
          is_success: false,
          data: {}
        }, status: :failure
      end
    end

end
