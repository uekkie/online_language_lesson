class AddCouponTypeToCouponBalances < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_balances, :period, :boolean, null: false, default: false
  end
end
