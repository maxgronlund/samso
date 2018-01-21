# helpers for the CalendarHelper
module Admin::CalendarModuleHelper
  def prev_month(current_month = nil)
    current_month = Date.today.at_beginning_of_month.to_s if current_month.nil?
    (Date.parse(current_month) - 1.month).to_s
  end

  def next_month(current_month = nil)
    current_month = Date.today.at_beginning_of_month.to_s if current_month.nil?
    (Date.parse(current_month) + 1.month).to_s
  end

  def calendar_module_events(calendar_module, from_date = nil)
    from_date = from_date.nil? ? Date.today.at_beginning_of_month : Date.parse(from_date)
    calendar_module
      .events
      .order('start_time ASC')
      .where(
        'start_time >= :from_date AND start_time <= :to_date', from_date: from_date, to_date: from_date + 1.month
      )
  end

  # rubocop:disable Metrics/AbcSize
  def this_month_name(from_date = nil)
    if from_date.nil?
      month = Date.today.month
      year = Date.today.year
    else
      month = Date.parse(from_date).month
      year = Date.parse(from_date).year
    end
    month_name = I18n.t('date.month_names')[month] + ' - ' + year.to_s
    month_name.capitalize
  end
  # rubocop:enable Metrics/AbcSize

  def calendar_module_events_today(calendar_module)
    today = Date.today
    calendar_module
      .events
      .order('start_time ASC')
      .where(
        'start_time >= :from_date AND start_time <= :to_date', from_date: today, to_date: today + 1.day
      )
  end
end
