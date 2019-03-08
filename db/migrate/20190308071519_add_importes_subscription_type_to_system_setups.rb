class AddImportesSubscriptionTypeToSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :subscription_id, :integer
    add_column :admin_system_setups, :free_subscription_id, :integer
  end
end
