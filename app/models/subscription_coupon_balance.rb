class SubscriptionCouponBalance < ApplicationRecord
  belongs_to :subscription
  belongs_to :coupon_balance
end
