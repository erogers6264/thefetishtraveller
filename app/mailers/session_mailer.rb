class SessionMailer < ApplicationMailer
  def login(user)
    @user = user
    mail to: user.email
  end
end