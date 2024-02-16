class InviteMailer < ApplicationMailer

  def send_link
    @invite = params[:invite]
    @invite_url = "http://localhost:3000/users/sign_up?token=#{params[:invite][:token]}"
    mail(to: @invite[:email], subject: "Вы приглашены")
  end

end
