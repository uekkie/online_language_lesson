class Users::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
  end

  def create
    plan = Plan.find(params[:plan_id])

    customer = params[:use_registerd_id].present? ?
                   current_user.customer :
                   current_user.attach_customer(params[:stripeToken])

    if current_user.subscribe(customer, plan)
      redirect_to users_reservations_url, notice: 'チケットを購入しました'
    else
      redirect_to new_users_charge_path
    end
  end
end
