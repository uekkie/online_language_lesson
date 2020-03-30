class Admins::MonthlyGraphsController < Admins::ApplicationController
  before_action :set_teacher, only: :show

  def index
    @teachers = Teacher.without_admin
  end

  def show
    @teachers_stats = teachers_stats
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teachers_stats
    lessons_group_by_month = @teacher.lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count
    @reserved_lessons = @teacher.lessons.where.not(reservation: nil)
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
end
