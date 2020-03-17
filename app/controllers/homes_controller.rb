class HomesController < ApplicationController
  def index
    if teacher_signed_in?
      if current_teacher.admin?
        redirect_to teachers_url
      else
        redirect_to lessons_url
      end
    elsif user_signed_in?
      redirect_to users_reservations_url
    end
  end
end
