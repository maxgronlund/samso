# give some users a free subscription
class AddFreeSubscriptionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :free_subscription, :boolean, default: false
  end
end
