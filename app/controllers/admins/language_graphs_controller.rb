class Admins::LanguageGraphsController < Admins::ApplicationController
  before_action :set_language_name
  before_action :set_date, :date_range, if: :valid_date

  def index
    @languages = Language.unique
    lessons = Lesson.having_language_name(@language_name)
    set_language_stats(lessons)
    set_daily_stats(lessons)
  end

  private

  def set_language_name
    @language_name = params[:name]
  end

  def valid_date
    params[:date].present?
  end

  def set_date
    @origin_date = Date.parse(params[:date])
  end

  def date_range
    start_date = @origin_date.beginning_of_month.beginning_of_week(:sunday)
    end_date = @origin_date.end_of_month.end_of_week(:sunday)
    @date_range = (start_date..end_date)
  end

  def set_language_stats(lessons)
    @languages_stats = Lesson.booking_rates(lessons) if @language_name
  end

  def set_daily_stats(lessons)
    @languages_daily_stats = Lesson.daily_stats(lessons) if @language_name && @origin_date
  end
end
