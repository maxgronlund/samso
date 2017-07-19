# Default subscriptions page
class AddDaSubscriptionPageIdToAdminSystemSetups < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_system_setups, :da_subscription_page_id, :integer
    add_column :admin_system_setups, :en_subscription_page_id, :integer
  end
end
