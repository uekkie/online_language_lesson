class Admins::ApplicationController < ApplicationController
  before_action :authenticate_teacher!
  before_action :is_not_admin
  
  private
  
  def is_not_admin
    redirect_to root_path, alert: "管理者のみアクセス可能です" unless current_teacher.admin?
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

end
