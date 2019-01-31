class AddDafaultSubscriptionTypeIdToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :admin_subscription_type_id, :integer
  end
end
