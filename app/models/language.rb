class Language < ApplicationRecord
  belongs_to :teacher
  has_many :lessons, dependent: :destroy

  validates :name, uniqueness: { scope: :teacher_id }

  scope :recent, -> { order(created_at: :desc)}
end
