class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[edit update destroy]

  def index
    @teachers = Teacher.without_admin
  end

  def new
    @teacher = Teacher.new
  end

  def edit
  end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to @teacher, notice: 'Teacher was successfully created.'
    else
      render :new
    end
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: 'Teacher was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy!
    redirect_to teachers_url, notice: 'Teacher was successfully destroyed.'
  end

  def profile
    @teacher = current_teacher
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:name, :email, :introduce, :avatar_url)
  end
end
