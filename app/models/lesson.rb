class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :time_table
  belongs_to :language

  scope :recent, -> { order(created_at: :desc) }

end
