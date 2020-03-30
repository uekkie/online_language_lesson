module ApplicationHelper

  def not_signed_in?
    !(user_signed_in? || teacher_signed_in?)
  end

  def masquerade_signed_in?
    session[:admin_id].present?
  end

  def td_classes_for(day, start_date)
    today = Date.current

    td_class = ['day']
    td_class << "wday-#{day.wday.to_s}"
    td_class << 'today'         if today == day
    td_class << 'past'          if today > day
    td_class << 'future'        if today < day
    td_class << 'start-date'    if day.to_date == start_date.to_date
    td_class << 'prev-month'    if start_date.month != day.month && day < start_date
    td_class << 'next-month'    if start_date.month != day.month && day > start_date
    td_class << 'current-month' if start_date.month == day.month

    td_class
  end

end
