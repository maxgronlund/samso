# show weather from DMI
class Admin::CalendarModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  belongs_to :admin_calendar, class_name: 'Admin::Calendar', optional: true

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
end
