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

  def self.cell_color(percentage)
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
    reserved_lessons = lessons.where.not(reservation: nil)
    reserved_lessons_group_by_day = reserved_lessons.group_by_day(:date, format: "%Y-%m-%d,%a").count

    mapped_lessons = lessons_group_by_day.map do |date_week, lesson_count|
      reserve_count = reserved_lessons_group_by_day.has_key?(date_week) ? reserved_lessons_group_by_day[date_week] : 0
      {
          date_week.split(",").first => {
              lesson_count: lesson_count,
              reserve_count: reserve_count,
              cell_color: lesson_count>0 ? cell_color(reserve_count*100/lesson_count) : ""
          }
      }
    end
    mapped_lessons.inject({}){|result,item| result.merge(item)}
  end

  def self.languages_stats(lessons)
    lessons_group_by_month = lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count
    @reserved_lessons = lessons.where.not(reservation: nil)
    reserved_lessons_group_by_month = @reserved_lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count

    lessons_group_by_month.map do |k,v|
      reserve_count = reserved_lessons_group_by_month.has_key?(k) ? reserved_lessons_group_by_month[k] : 0
      {
        date: k.split(",").first,
        month:  k.split(",").second,
        lesson_count: v,
        reserve_count: reserve_count
      }
    end
  end

  def self.teachers_stats(lessons)
    lessons_group_by_month = lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count
    reserved_lessons = lessons.where.not(reservation: nil)
    reserved_lessons_group_by_month = reserved_lessons.group_by_month(:date, format: "%Y-%m-%d,%b").count

    lessons_group_by_month.map do |k,v|
      reserve_count = reserved_lessons_group_by_month.has_key?(k) ? reserved_lessons_group_by_month[k] : 0
      {
          date: k.split(",").first,
          month:  k.split(",").second,
          lesson_count: v,
          reserve_count: reserve_count
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
          color: cell_color(reserve*100/lesson)
      }
    end
  end
end
