class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[show edit update destroy sign_in]

  def index
    @teachers = Teacher.without_admin
  end

  def show
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

  def sign_in
    if current_teacher.admin?
      session[:teacher_agent] = @teacher.id
    end
    redirect_to root_url
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.fetch(:teacher, {})
  end
end
