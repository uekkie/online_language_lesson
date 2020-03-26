class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :language
  has_one :reservation
  has_one :feedback, class_name: 'LessonFeedback' 

  scope :recent, -> { order(created_at: :desc) }
  scope :latest, -> { order(:date)}

  validates :zoom_url, :date, :hour, presence: true

  LESSON_HOUR_RANGE = (7..22)

  def self.hour_default
    LESSON_HOUR_RANGE.first
  end

  def self.hour_range
    LESSON_HOUR_RANGE.map{ |n| ["#{n}:00〜", n]}
  end

  def start_at
    "#{I18n.l(date)} #{hour}:00〜"
  end

  def summary
    "#{teacher.name}先生の#{language.name}レッスン #{start_at}"
  end
end
