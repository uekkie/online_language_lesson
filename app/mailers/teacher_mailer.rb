class TeacherMailer < ApplicationMailer
  def accept_lesson(reservation)
    @lesson = reservation.lesson
    @user = reservation.user
    mail(to: @lesson.teacher.email, subject: '予約完了メール')
  end
end
