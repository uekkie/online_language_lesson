class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations
  has_many :coupon_balances

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

  def coupon_balance_empty?
    calc_coupon_balance == 0
  end

  def calc_coupon_balance
    coupon_balances.sum(:number)
  end
end
