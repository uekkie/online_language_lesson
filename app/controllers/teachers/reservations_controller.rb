class Teachers::ReservationsController < ApplicationController
  before_action :authenticate_teacher!

  def index
    @reservations = current_teacher_reservations
  end

  private

  def current_teacher_reservations
    if current_teacher.admin? && session[:teacher_agent].present?
      teacher = Teacher.find(session[:teacher_agent])
      teacher.reservations
    else
      current_teacher.reservations
    end
  end
end
