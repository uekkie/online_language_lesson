class DeletePeriodFromCouponBalances < ActiveRecord::Migration[6.0]
  def change
    remove_column :coupon_balances, :period
  end
end
