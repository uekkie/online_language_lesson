class Admins::ReservationsController < Admins::ApplicationController
  before_action :date_range

  def index
    @datas = calc_percentage(filtered_lessons)
  end

  private

  def date_range
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.tomorrow
    end_date = params[:end_date] ? Date.parse(params[:end_date]) : 15.days.since.to_date
    @date_range = start_date..end_date
  end

  def filtered_lessons
    Lesson.where(date: @date_range)
  end
end
