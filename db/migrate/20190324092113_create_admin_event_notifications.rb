class CreateAdminEventNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_event_notifications do |t|
      t.string :title
      t.text :body
      t.string :message_type
      t.string :state, default: 'pending'
      t.text :metadata

      t.timestamps
    end
  end
end
