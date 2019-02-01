class AddReminderSendToAdminSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_subscriptions, :reminder_send, :datetime
  end
end
