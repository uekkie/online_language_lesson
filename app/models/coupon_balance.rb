class CouponBalance < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  scope :available, -> {
    where("expire_at > ?", Date.current)
  }
  scope :subscriptions, -> {
    where.not(subscription: nil).available
  }
  scope :infinite, -> {
    where(subscription: nil)
  }
end
