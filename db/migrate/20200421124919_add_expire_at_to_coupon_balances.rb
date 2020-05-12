class AddExpireAtToCouponBalances < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_balances, :expire_at, :datetime, null: false, default: 20.years.since
  end
end
