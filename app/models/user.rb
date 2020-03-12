class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations
  has_many :ticket_balances

  def create_stripe_customer(stripe_token)
    customer = Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
  end

  def stripe_customer(stripe_token)
    return Stripe::Customer.retrieve(stripe_customer_id) if stripe_customer_id.present?

    customer = Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
    self.update_attribute(:stripe_customer_id, customer.id)
    customer
  end

  def calc_ticket_balance
    ticket_balances.sum(:amount)
  end
end
