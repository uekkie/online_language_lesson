class UserMailer < ApplicationMailer
  def accept_lesson(reservation)
    @lesson = reservation.lesson
    @user = reservation.user
    mail(to: @user.email, subject: '予約完了メール')
  end

  def recv_feedback(lesson_feedback)
    @user = lesson_feedback.user
    @lesson_feedback = lesson_feedback
    mail(to: @user, subject: 'フィードバックがありました')
  end

end
