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

  def edit
    @user = current_user
  end

  def update
    case params[:subscription][:update_type]
    when "plan"
      update_plan
    when "suspend"
      update_suspend
    when "card"
      update_card
    end
  end

  private

  def update_plan
    if current_user.subscription.update(subscription_params)
      redirect_to user_url(current_user), notice: 'プランを更新しました'
    else
      @user = current_user
      render :edit
    end
  end

  def update_suspend
    if current_user.subscription.update(subscription_params)
      redirect_to user_url(current_user), notice: "プランを#{current_user.subscription.suspend_status}に変更しました"
    else
      @user = current_user
      render :edit
    end
  end

  def update_card
    if current_user.update_stripe_token(params[:stripeToken])
      redirect_to user_url(current_user), notice: 'カードを更新しました'
    else
      @user = current_user
      render :edit
    end
  end

  def subscription_params
    params.require(:subscription).permit(:plan_id, :suspend)
  end
end
