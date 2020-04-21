class CouponBalance < ApplicationRecord
  belongs_to :user

  scope :available, -> {
    where("expire_at > ?", Date.current)
  }
end
