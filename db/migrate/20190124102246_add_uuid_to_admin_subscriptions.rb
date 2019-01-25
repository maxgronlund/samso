class AddUuidToAdminSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_subscriptions, :uuid, :uuid
  end
end
