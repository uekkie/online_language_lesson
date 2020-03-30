class Admins::LanguageGraphsController < Admins::ApplicationController
  before_action :set_date

  def index
    @languages = Language.unique
    @language_name = params[:name]
    if @language_name
      lessons = Lesson.joins(:language).where("languages.name = ?", @language_name)
      @languages_stats = languages_stats(lessons)
      if @origin_date
        @languages_daily_stats = daily_stats(lessons)
      end
    end
  end

  private

  def set_date
    return if params[:date].blank?
    @origin_date = Date.parse(params[:date])
    @start_date = @origin_date.beginning_of_month.beginning_of_week(:sunday)
    @end_date = @origin_date.end_of_month.end_of_week(:sunday)
    @date_range = (@start_date..@end_date).to_a
  end

  def languages_stats(lessons)
    lessons_group_by_month = lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count
    @reserved_lessons = lessons.where.not(reservation: nil)
    @reserved_lessons_group_by_month = @reserved_lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count

    lessons_group_by_month.map do |k,v|
      reserve_count = @reserved_lessons_group_by_month.has_key?(k) ? @reserved_lessons_group_by_month[k] : 0
      {
          date: k.split(",").first,
          month:  k.split(",").second,
          lesson_count: v,
          reserve_count: reserve_count
      }
    end
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
