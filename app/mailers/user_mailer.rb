class UserMailer < ApplicationMailer
  default from: "exlicabur9218@gmail.com"

  def activation_mail(user)
    @user = user
    mail to: @user.email, subject: "Please activate your account"
  end
end
