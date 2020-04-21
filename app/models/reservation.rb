class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  scope :recent, -> { order(created_at: :desc)}
  scope :finished, -> { joins(:lesson).where("lessons.date < ?", Date.current) }
end
