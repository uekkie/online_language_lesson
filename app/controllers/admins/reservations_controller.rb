class Admins::ReservationsController < Admins::ApplicationController
  before_action :set_date
  before_action :filtered_lessons

  def index
    @datas = calc_percentage(@filtered_lessons)
  end

  private

  def set_date
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.tomorrow
    @end_date = params[:end_date] ? Date.parse(params[:end_date]) : 15.days.since.to_date
  end

  def filtered_lessons
    @filtered_lessons = Lesson.where(date: @start_date..@end_date)
  end
end
