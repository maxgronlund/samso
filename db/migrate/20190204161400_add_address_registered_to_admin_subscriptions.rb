class AddAddressRegisteredToAdminSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_subscriptions, :address_registered, :boolean, default: false
  end
end
