# Calendars for the calendar_modules
class CreateAdminCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_calendars do |t|
      t.string :title

      t.timestamps
    end
  end
end
