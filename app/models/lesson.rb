class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :language
  has_many :reservations, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
  scope :latest, -> { order(:start_date)}

  def start_at
    I18n.l(start_date, format: :discard_minute)
  end

  def summary
    "#{teacher.name}先生の#{language.name}レッスン #{start_at}"
  end
end
