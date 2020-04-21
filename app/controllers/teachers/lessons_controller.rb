class Teachers::LessonsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    if current_teacher.admin?
      redirect_to root_path
    end

    @lessons = current_teacher.lessons.recent
  end

  def show
  end

  def new
    @lesson = current_teacher.lessons.build
  end

  def edit
  end

  def create
    @lesson = current_teacher.lessons.build(lesson_params)

    if @lesson.save
      redirect_to teachers_lessons_url, notice: 'レッスンを追加しました'
    else
      render :new
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to teachers_lessons_url, notice: 'レッスンを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy!
    redirect_to teachers_lessons_url, notice: 'レッスンを削除しました'
  end


  def select_lesson
    @lessons = Lesson.latest
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:language_id, :zoom_url, :date, :hour)
  end
end
