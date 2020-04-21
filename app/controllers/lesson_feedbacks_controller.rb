class LessonFeedbacksController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_lesson_feedback, only: [:show, :edit, :update, :destroy]

  def index
    @lesson_feedbacks = LessonFeedback.all
    @reservations = current_teacher.reservations.finished
  end

  def show
  end

  def new
    reservation = current_teacher.reservations.find(params[:reservation_id])
    @lesson_feedback = LessonFeedback.new
    @lesson_feedback.lesson = reservation.lesson
  end

  def edit
  end

  def create
    @lesson_feedback = LessonFeedback.new(lesson_feedback_params)

    if @lesson_feedback.save
      UserMailer.recv_feedback(@lesson_feedback).deliver_later

      redirect_to @lesson_feedback, notice: 'フィードバックを作成しました'
    else
      render :new
    end
  end

  def update
    if @lesson_feedback.update(lesson_feedback_params)
      redirect_to @lesson_feedback, notice: 'フィードバックを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @lesson_feedback.destroy
    redirect_to lesson_feedbacks_url, notice: 'フィードバックを削除しました'
  end

  private
    def set_lesson_feedback
      @lesson_feedback = LessonFeedback.find(params[:id])
    end

    def lesson_feedback_params
      params.require(:lesson_feedback).permit(:lesson_id, :user_id, :content)
    end
end
