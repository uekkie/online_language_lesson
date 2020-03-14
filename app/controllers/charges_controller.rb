class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
  end

  def create
    coupon = Coupon.find(params[:coupon_id])

    customer = params[:use_registerd_id].present? ?
                   current_user.customer :
                   current_user.attach_customer(params[:stripeToken])

    Stripe::Charge.create(
      :customer => customer.id,
      :amount => coupon.price,
      :description => "Onlineレッスンチケット #{coupon.name}",
      :currency => "jpy"
    )
    current_user.coupon_balances.create(
        number: coupon.number
    )
    redirect_to reservations_url, notice: 'チケットを購入しました'

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


end
