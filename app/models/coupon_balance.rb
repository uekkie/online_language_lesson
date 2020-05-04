class CouponBalance < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  scope :available, -> {
    where("expire_at > ?", Date.current)
  }
  scope :subscriptions, -> {
    where(period: true).available
  }
  scope :infinite, -> {
    where(period: false)
  }
end
