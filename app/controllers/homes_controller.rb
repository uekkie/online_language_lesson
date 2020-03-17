class HomesController < ApplicationController
  def index
    if teacher_signed_in?
      redirect_to current_teacher.admin? ?  teachers_url :  teachers_lessons_url
    elsif user_signed_in?
      redirect_to users_reservations_url
    end
  end
end
