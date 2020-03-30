class Admins::DailyGraphsController < Admins::ApplicationController
  before_action :set_teacher, :set_date

  def index
    @datas = calc_percentage(@teacher.lessons)
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:monthly_graph_id])
  end

  def set_date
    @start_date = params[:date] ? Date.parse(params[:date]).beginning_of_month : Date.current.beginning_of_month
    @end_date = @start_date.end_of_month
  end
end
