class AddSubscriptionIdToAdminSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscriptions, :subscription_id, :integer
    add_column :admin_subscriptions, :on_hold_date, :datetime
  end
end
