class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, dependent: :destroy
  has_many :coupon_balances, dependent: :destroy

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

  def coupon_balance_empty?
    calc_coupon_balance == 0
  end

  def calc_coupon_balance
    coupon_balances.sum(:number)
  end
end
