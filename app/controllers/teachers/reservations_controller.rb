class Teachers::ReservationsController < ApplicationController
  before_action :authenticate_teacher!

  def index
    @reservations = current_teacher.reservations
  end
end
