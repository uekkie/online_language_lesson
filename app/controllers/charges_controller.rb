class Ticket
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :integer
  attribute :name, :string, default: "1回"
  attribute :price, :integer, default: 2000
  attribute :amount, :integer, default: 1
end

class ChargesController < ApplicationController
  before_action :authenticate_user!
  def new
    @tickets = [
      Ticket.new(id: 1, name: '1回', price: 2000, amount: 1),
      Ticket.new(id: 2, name: '5回', price: 7500, amount: 5)
    ]
  end

  def create
    customer = current_user.stripe_customer(params[:stripeToken])

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => 7500,
      :description => 'Onlineレッスンチケット',
      :currency => "jpy"
    )
    current_user.ticket_balances.create(
      amount: 5
    )
    redirect_to reservation_url, notice: 'チケットを購入しました'

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


end
