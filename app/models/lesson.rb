class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :language
  has_one :reservation, dependent: :destroy
  has_one :feedback, class_name: 'LessonFeedback' 
  has_one :report

  has_one :user, through: :reservation

  scope :recent, -> { order(created_at: :desc) }
  scope :latest, -> { order(:date)}
  scope :query_language, -> (language_id) { where(language_id: language_id) if language_id.present? }

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
