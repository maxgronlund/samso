# frozen_string_literal: true

# Events for the calendar
class Admin::CalendarEvent < ApplicationRecord
  belongs_to :calendar, class_name: 'Admin::Calendar', counter_cache: true

  validates :title, :start_time, :calendar_id, presence: true
end
