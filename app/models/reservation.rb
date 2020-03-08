class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  scope :recent, -> { order(created_at: :desc)}
end
