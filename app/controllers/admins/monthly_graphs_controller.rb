class Admins::MonthlyGraphsController < ApplicationController
  before_action :set_teacher, :set_date, only: :show

  def index
    @teachers = Teacher.all
  end

  def show
    @datas = calc_percentage(@teacher.lessons)
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def calc_percentage(lessons)
    lesson_hash = lessons.order(:date, :hour).group(:date, :hour).count

    reserve_hash = lessons.where(
        id: Reservation.pluck(:lesson_id)
    ).order(:date, :hour).group(:date, :hour).count

    lesson_zero_padding_hash = lesson_hash.keys.map{|k| [k,0]}.to_h
    reserve_zero_padding_hash = lesson_zero_padding_hash.merge(reserve_hash)

    lesson_hash.merge(reserve_zero_padding_hash) do |key, lesson, reserve|
      {
          lesson_count: lesson,
          reserve_count: reserve,
          percentage: reserve*100/lesson,
          color: cell_color(reserve*100/lesson)
      }
    end
  end

  def cell_color(percentage)
    case percentage
    when 0..50 then
      "blue"
    when 51..80 then
      "orange"
    else
      "red"
    end
  end

  def set_date
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.tomorrow
    @end_date = params[:end_date] ? Date.parse(params[:end_date]) : 15.days.since.to_date
  end
end
