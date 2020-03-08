class HomesController < ApplicationController
  def index
    if teacher_signed_in?
      redirect_to lessons_url
    elsif user_signed_in?
      redirect_to reservations_url
    end
  end
end
