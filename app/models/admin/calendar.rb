# calendar to embed inside calendar module
class Admin::Calendar < ApplicationRecord
  has_many :events, class_name: 'Admin::CalendarEvent', dependent: :destroy
end
