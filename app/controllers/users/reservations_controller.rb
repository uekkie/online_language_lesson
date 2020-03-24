class Users::ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[show edit]
  before_action :pay_coupon, only: :create

  def index
    @reservations = current_user.reservations.recent
  end

  def show
  end

  def new
    @reservation = Reservation.new
    @lesson = Lesson.find(params[:lesson_id])
  end

  def edit
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.save
      UserMailer.accept_lesson(@reservation).deliver_later
      TeacherMailer.accept_lesson(@reservation).deliver_later
      redirect_to users_reservations_url, notice: '予約を承りました'
    else
      render :new
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:lesson_id, :start_date)
  end

  def pay_coupon
    raise BadRequest, 'チケット残高がありません' if current_user.coupon_balance_empty?
    current_user.coupon_balances.create(number: -1)
  end
end
