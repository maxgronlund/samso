class RenameSubscriptionIdOnAdminSubscriptions < ActiveRecord::Migration[5.2]
  def change
    remove_column :admin_subscriptions, :subscription_id, :integer
    add_column :admin_subscriptions, :subscription_id, :string, default: ''
  end
end
