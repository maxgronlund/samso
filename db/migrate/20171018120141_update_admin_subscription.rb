# can be deleted, original migration updated
class UpdateAdminSubscription < ActiveRecord::Migration[5.1]
  def up
    remove_column :admin_subscriptions, :duration
  end

  def down
    add_column :admin_subscriptions, :duration, :string
  end
end
