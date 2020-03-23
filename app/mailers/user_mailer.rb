class UserMailer < ApplicationMailer
  def accept_lesson(reservation)
    @lesson = reservation.lesson
    @user = reservation.user
    mail(to: @user.email, subject: '予約完了メール')
  end
end
