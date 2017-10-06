class CreateAdminCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_calendar_events do |t|
      t.belongs_to :admin_calendar, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
