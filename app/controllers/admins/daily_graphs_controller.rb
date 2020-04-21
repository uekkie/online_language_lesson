class Admins::DailyGraphsController < Admins::ApplicationController
  before_action :set_teacher, :set_date, :date_range

  def index
    @daily_stats = Lesson.daily_stats(filtered_lessons)
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:monthly_graph_id])
  end

  def set_date
    @origin_date = params[:date] ? Date.parse(params[:date]) : Date.current
  end

  def date_range
    start_date = @origin_date.beginning_of_month.beginning_of_week(:sunday)
    end_date = @origin_date.end_of_month.end_of_week(:sunday)
    @date_range = (start_date..end_date)
  end

  def filtered_lessons
    @teacher.lessons.where(date: date_range)
  end
end
