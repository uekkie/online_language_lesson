class Teachers::MultiLessonRegistersController < ApplicationController
  before_action :set_date, :date_range
  before_action :parse_days, only: :create

  def new
  end

  def create
    if @days.blank?
      redirect_to new_teachers_multi_lesson_register_url, alert: '日付を選択してください'
      return
    end
    lesson_count = Lesson.count
    Lesson.transaction do
      @days.each do |day|
        @lesson = current_teacher.lessons.build(lesson_params_without_date)
        @lesson.date = day
        @lesson.save!
      end
    end

    if Lesson.count == lesson_count + @days.count
      redirect_to teachers_lessons_url, notice: "レッスンを#{@days.count}件追加しました"
    else
      render :new
    end
  end

  private

  def parse_days
    @days = params[:days].split(",").map do |day|
        Date.parse(day)
    end
  end

  def lesson_params_without_date
    params.permit(:language_id, :hour, :zoom_url)
  end

  def set_date
    @origin_date = Date.current
  end

  def date_range
    start_date = @origin_date.beginning_of_month.beginning_of_week(:sunday)
    end_date = @origin_date.end_of_month.end_of_week(:sunday)
    @date_range = (start_date..end_date)
  end
end
