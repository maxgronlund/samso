class AddImportesSubscriptionTypeToSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :subscription_type_id, :integer
    add_column :admin_system_setups, :free_subscription_type_id, :integer
  end
end
