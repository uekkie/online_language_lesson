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

  scope :having_language_name, ->(language_name) {
    joins(:language).where("languages.name = ?", language_name)
  }
  scope :reserved, -> {
    joins(:reservation)
  }

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

  def self.cell_color(reserve, lesson)
    return "" if lesson == 0
    percentage = (reserve*100/lesson)

    case percentage
    when 0..50 then
      "low"
    when 51..80 then
      "usual"
    else
      "full"
    end
  end

  def self.daily_stats(lessons)
    lessons_group_by_day = lessons.group_by_day(:date, format: "%Y-%m-%d,%a").count
    reserved_lessons_group_by_day = lessons.reserved.group_by_day(:date, format: "%Y-%m-%d,%a").count
    mapped_lessons = lessons_group_by_day.map do |date_week, lesson_count|
      reserve_count = reserved_lessons_group_by_day[date_week] || 0
      {
        date_week.split(",").first => {
          lesson_count: lesson_count,
          reserve_count: reserve_count,
          cell_color: cell_color(reserve_count, lesson_count)
        }
      }
    end
    mapped_lessons.inject({}){|result,item| result.merge(item)}
  end

  def self.booking_rates(lessons)
    lessons_group_by_month = lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count
    reserved_lessons_group_by_month = lessons.reserved.group_by_month(:date, format: "%Y-%m-%d,%b").count

    lessons_group_by_month.map do |date_month, lesson_count|
      {
        date: date_month.split(",").first,
        month:  date_month.split(",").second,
        lesson_count: lesson_count,
        reserve_count: reserved_lessons_group_by_month[date_month] || 0
      }
    end
  end

  def self.calc_percentage(lessons)
    lesson_hash = lessons.order(:date, :hour).group(:date, :hour).count

    reserve_hash = lessons.where(
        id: Reservation.pluck(:lesson_id)
    ).order(:date, :hour).group(:date, :hour).count

    lesson_zero_padding_hash = lesson_hash.keys.map{|k| [k,0]}.to_h
    reserve_zero_padding_hash = lesson_zero_padding_hash.merge(reserve_hash)

    lesson_hash.merge(reserve_zero_padding_hash) do |key, lesson, reserve|
      {
          lesson_count: lesson,
          reserve_count: reserve,
          percentage: reserve*100/lesson,
          color: cell_color(reserve, lesson)
      }
    end
  end

  def self.bulk_create(teacher, days, lesson_params_without_date)
    Lesson.transaction do
      days.each do |day|
        lesson = teacher.lessons.build(lesson_params_without_date)
        lesson.date = day
        lesson.save!
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
