# frozen_string_literal: true

# Calendars for the calendar_modules
class CreateAdminCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_calendars do |t|
      t.string :title
      t.integer :calendar_events_count
      t.string :locale

      t.timestamps
    end
  end
end
