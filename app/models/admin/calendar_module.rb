# show weather from DMI
class Admin::CalendarModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  belongs_to :admin_calendar, class_name: 'Admin::Calendar', optional: true

  LAYOUTS =
    [
      [I18n.t('admin/calendar_module.layout.today-overview'), 'today_overview'],
      [I18n.t('admin/calendar_module.layout.today-detailed'), 'today_detailed'],
      [I18n.t('admin/calendar_module.layout.month-overview'), 'month_overview'],
      [I18n.t('admin/calendar_module.layout.month-detailed'), 'month_detailed']
    ].freeze

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::CalendarModule',
      moduleable_id: id
    )
  end

  def events
    return [] if admin_calendar.nil?
    admin_calendar.events
  end

  def prev_page(request_path, current_page)
    page = current_page.to_i - 1
    return request_path if page <= 0
    "#{request_path}?page=#{page}"
  end

  def next_page(request_path, current_page)
    page = current_page.to_i + 1
    return false if page * posts_pr_page >= blog_posts_count
    "#{request_path}?page=#{page}"
  end
end
