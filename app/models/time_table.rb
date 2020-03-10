class TimeTable < ApplicationRecord

  def start_time_format
    I18n.l(start_time, format: :time_only)
  end
end
