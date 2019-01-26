class CleanAdminSubscriptions < ActiveRecord::Migration[5.2]
  def up
    remove_column :admin_subscriptions, :uuid
    remove_column :admin_subscriptions, :state
  end

  def down
    add_column :admin_subscriptions, :uuid, :uuid
    add_column :admin_subscriptions, :state, :string, default: 'pending'
  end
end
