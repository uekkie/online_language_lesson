class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, dependent: :destroy
  has_many :coupon_balances, dependent: :destroy
  has_many :lesson_feedbacks, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :lessons, through: :reservations

  has_one :subscription, dependent: :destroy
  def has_customer_id?
    stripe_customer_id.present?
  end

  def customer
    return Stripe::Customer.retrieve(stripe_customer_id) if stripe_customer_id.present?
  end

  def attach_customer(stripe_token)
    customer = Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
    self.update_attribute(:stripe_customer_id, customer.id)
    customer
  end

  def charge(customer, coupon)
    Stripe::Charge.create(
        :customer => customer.id,
        :amount => coupon.price,
        :description => "Onlineレッスンチケット #{coupon.name}",
        :currency => "jpy"
    )
    self.coupon_balances.create(number: coupon.number)
    true
  rescue Stripe::CardError => e
    flash[:error] = e.message
    false
  end

  def subscribe(customer, plan)
    Stripe::Charge.create(
        :customer => customer.id,
        :amount => plan.price,
        :description => "Onlineレッスン定期チケット #{plan.name}",
        :currency => "jpy"
    )
    self.coupon_balances.create(number: plan.number, expire_at: 30.days.since, period: true)
    Subscription.create(user: self, plan_id: plan.id, start_at: Date.current)
    true
  rescue Stripe::CardError => e
    flash[:error] = e.message
    false
  end

  def coupon_balance_empty?
    calc_coupon_balance == 0
  end

  def calc_coupon_balance
    coupon_balances.available.sum(:number)
  end

  def subscription_balance
    coupon_balances.subscriptions.sum(:number)
  end

  def infinite_balance
    coupon_balances.infinite.sum(:number)
  end

  def subscription_expire_at
    return nil if subscription_balance == 0
    coupon_balances.available.first.expire_at
  end
end
