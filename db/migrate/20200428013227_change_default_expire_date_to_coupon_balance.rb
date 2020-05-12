class ChangeDefaultExpireDateToCouponBalance < ActiveRecord::Migration[6.0]
  def change
    change_column :coupon_balances, :expire_at, :datetime, default: 100.years.since
  end
end
