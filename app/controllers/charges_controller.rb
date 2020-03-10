class Ticket
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string, default: "1回"
  attribute :price, :integer, default: 2000
end

class ChargesController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def create
    # Amount in cents
    @amount = 500
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'Onlineレッスンチケット',
      :currency => "jpy"
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


end
