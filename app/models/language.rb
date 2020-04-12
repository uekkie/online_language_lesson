class Language < ApplicationRecord
  has_many :lessons, dependent: :destroy

  scope :recent, -> { order(created_at: :desc)}
end
