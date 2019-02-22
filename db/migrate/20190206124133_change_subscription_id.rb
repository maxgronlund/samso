class ChangeSubscriptionId < ActiveRecord::Migration[5.2]
  def up
    add_column :admin_subscriptions, :temp, :integer
    Admin::Subscription.find_each do |subscription|
      subscription.update(temp: subscription.subscription_id.to_i)
    end
    remove_column :admin_subscriptions, :subscription_id, :integer
    rename_column :admin_subscriptions, :temp, :subscription_id
  end

  def down
    change_column :admin_subscriptions, :subscription_id, :string
  end
end
