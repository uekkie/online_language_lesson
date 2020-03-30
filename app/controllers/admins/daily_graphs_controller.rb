class Admins::DailyGraphsController < Admins::ApplicationController
  before_action :set_teacher, :set_date

  def index
    filtered_lessons
    @daily_stats = daily_stats(@filtered_lessons)
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:monthly_graph_id])
  end

  def set_date
    @origin_date = params[:date] ? Date.parse(params[:date]) : Date.current
    @start_date = @origin_date.beginning_of_month.beginning_of_week
    @end_date = @origin_date.end_of_month.end_of_week   
    @date_range = (@start_date..@end_date).to_a
  end

  def filtered_lessons
    @filtered_lessons = @teacher.lessons.where(date: @start_date..@end_date)
  end

  def daily_stats(lessons)
    lessons_group_by_day = lessons.group_by_day(:date, format: "%Y-%m-%d,%a").count
    @reserved_lessons = lessons.where.not(reservation: nil)
    @reserved_lessons_group_by_day = @reserved_lessons.group_by_day(:date, format: "%Y-%m-%d,%a").count
    
    lessons_group_by_day.map do |k,v|
      reserve_count = @reserved_lessons_group_by_day.has_key?(k) ? @reserved_lessons_group_by_day[k] : 0
      {
        date: k.split(",").first,
        week:  k.split(",").second,
        lesson_count: v,
        reserve_count: reserve_count
      }
    end
  end
end
