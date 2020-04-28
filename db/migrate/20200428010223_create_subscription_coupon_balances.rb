class CreateSubscriptionCouponBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :subscription_coupon_balances do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :coupon_balance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
