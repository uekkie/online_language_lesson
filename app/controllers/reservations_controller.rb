class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :pay_ticket, only: :create

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
      redirect_to reservation_url(@reservation), notice: '予約を承りました'
    else
      render :new
    end
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to @reservation, notice: 'Reservation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:lesson_id, :date)
  end

  def pay_ticket
    raise BadRequest, 'チケット残高がありません' if current_user.ticket_balance_empty?
    current_user.ticket_balances.create(amount: -1)
  end
end
