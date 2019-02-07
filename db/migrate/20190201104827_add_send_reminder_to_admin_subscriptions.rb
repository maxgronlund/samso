class AddSendReminderToAdminSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_subscriptions, :send_reminder, :boolean, default: false
  end
end
