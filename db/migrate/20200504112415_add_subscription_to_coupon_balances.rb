class AddSubscriptionToCouponBalances < ActiveRecord::Migration[6.0]
  def change
    add_reference :coupon_balances, :subscription, null: true, default: nil, foreign_key: true
  end
end
