class AddUsersCountToAdminSubscriptionTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscription_types, :subscriptions_count, :integer
  end
end
