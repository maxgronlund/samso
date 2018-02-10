class AddFreeToAdminSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscription_types, :free, :boolean, default: false
  end
end
