# frozen_string_literal: true

# calendar to embed inside calendar module
class Admin::Calendar < ApplicationRecord
  has_many :events, class_name: 'Admin::CalendarEvent', dependent: :destroy
  has_many :admin_calendar_modules, class_name: 'Admin::CalendarModule', dependent: :nullify, foreign_key: 'admin_calendar_id'
end
