class AddReminderToSubscriptionTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_subscription_types, :send_reminder, :boolean, default: false
    add_column :admin_subscription_types, :remind_before_days, :integer, default: 1
  end
end
