class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :time_table
  belongs_to :language

  scope :recent, -> { order(created_at: :desc) }

  def start_at
    I18n.l(time_table.start_time, format: :time_only)
  end

  def summary
    "#{teacher.name}先生の#{language.name}レッスン #{start_at}"
  end
end
