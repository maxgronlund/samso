# Events for the calendar
class Admin::CalendarEvent < ApplicationRecord
  belongs_to :calendar, class_name: 'Admin::Calendar'

  validates :title, :start_time, :calendar_id, presence: true
end
