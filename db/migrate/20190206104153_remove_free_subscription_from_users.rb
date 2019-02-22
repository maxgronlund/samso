class RemoveFreeSubscriptionFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :free_subscription, :boolean
  end
end
