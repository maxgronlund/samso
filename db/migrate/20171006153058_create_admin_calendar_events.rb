class CreateAdminCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_calendar_events do |t|
      t.integer :calendar_id
      t.string :title
      t.text :body
      t.text :location
      t.string :gmap
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    add_index :admin_calendar_events, :calendar_id
  end
end
