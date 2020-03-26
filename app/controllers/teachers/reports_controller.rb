class Teachers::ReportsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_lesson, only: %i[show edit update destroy]
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.recent
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params) do |report|
      report.user_id = @reservation.user.id
      report.lesson_id = @reservation.lesson.id
      report
    end

    if @report.save
      redirect_to @report
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to teachers_lesson_report_url(@lesson, @report)
    else
      render :edit
    end
  end

  private

  def report_params
    params.require(:report).permit(:content)
  end

  def set_lesson
    @lesson = current_teacher.lessons.find(params[:lesson_id])
  end

  def set_report
    @report = @lesson.report
  end
end
