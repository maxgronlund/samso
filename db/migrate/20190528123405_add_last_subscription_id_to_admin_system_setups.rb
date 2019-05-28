class AddLastSubscriptionIdToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :last_subscription_id, :integer, default: 8005250
  end
end
