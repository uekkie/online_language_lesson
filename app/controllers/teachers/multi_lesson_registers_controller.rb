class Teachers::MultiLessonRegistersController < ApplicationController
  before_action :parse_days, only: :create

  def new

  end

  def create
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
end
