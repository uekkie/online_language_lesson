class TeachersController < ApplicationController
  before_action :authenticate_teacher!
  before_action :signed_in_admin, except: :profile

  before_action :set_teacher, only: %i[update destroy]

  def index
    @teachers = Teacher.without_admin
  end

  def destroy
    @teacher.destroy!
    redirect_to teachers_url, notice: '削除しました'
  end

  def profile
    @teacher = current_teacher
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def signed_in_admin
    unless current_teacher.admin?
      redirect_to new_teacher_session_url, alert: '管理者でログインしてください'
    end
  end
end
