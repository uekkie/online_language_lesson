class UserMailer < ApplicationMailer
  default from: 'hirocueki@gmail.com'

  def accepted_reservation
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: '私の素敵なサイトへようこそ')
  end
end
