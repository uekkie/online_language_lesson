class Admins::MonthlyGraphsController < Admins::ApplicationController
  before_action :set_teacher, only: :show

  def index
    @teachers = Teacher.without_admin
  end

  def show
    @teachers_stats = Lesson.teachers_stats(@teacher.lessons)
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end
end
