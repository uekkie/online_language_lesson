class Report < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  has_one :teacher, through: :lesson

  scope :recent, -> { order(created_at: :desc) }
end
