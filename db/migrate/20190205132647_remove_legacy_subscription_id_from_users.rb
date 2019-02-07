class RemoveLegacySubscriptionIdFromUsers < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :legacy_subscription_id, :integer
  end
end
