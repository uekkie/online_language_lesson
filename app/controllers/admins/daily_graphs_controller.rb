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
    @start_date = @origin_date.beginning_of_month.beginning_of_week(:sunday)
    @end_date = @origin_date.end_of_month.end_of_week(:sunday)
    @date_range = (@start_date..@end_date).to_a
  end

  def filtered_lessons
    @filtered_lessons = @teacher.lessons.where(date: @start_date..@end_date)
  end

  def daily_stats(lessons)
    lessons_group_by_day = lessons.group_by_day(:date, format: "%Y-%m-%d,%a").count
    @reserved_lessons = lessons.where.not(reservation: nil)
    @reserved_lessons_group_by_day = @reserved_lessons.group_by_day(:date, format: "%Y-%m-%d,%a").count
    
    maped_lessons = lessons_group_by_day.map do |date_week, lesson_count|
      reserve_count = @reserved_lessons_group_by_day.has_key?(date_week) ? @reserved_lessons_group_by_day[date_week] : 0
      {
        date_week.split(",").first => {
          lesson_count: lesson_count,
          reserve_count: reserve_count,
          cell_color: lesson_count>0 ? cell_color(reserve_count*100/lesson_count) : ""
        }
      }
    end

    maped_lessons.inject({}){|result,item| result.merge(item)}
  end
end
