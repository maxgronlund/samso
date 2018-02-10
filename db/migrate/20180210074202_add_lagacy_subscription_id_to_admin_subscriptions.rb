class AddLagacySubscriptionIdToAdminSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscriptions, :legacy_subscription_id, :string, default: ''
  end
end
