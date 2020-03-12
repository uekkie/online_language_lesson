class ChargesController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def create
    coupon = Coupon.find(params[:coupon_id])

    customer = current_user.stripe_customer(params[:stripeToken])

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => coupon.price,
      :description => "Onlineレッスンチケット #{coupon.name}",
      :currency => "jpy"
    )
    current_user.ticket_balances.create(
      amount: coupon.number
    )
    redirect_to reservations_url, notice: 'チケットを購入しました'

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


end
