class AddAddressTypeToAddresses < ActiveRecord::Migration[5.2]
  def up
    add_column :addresses, :address_type, :string, default: 'user_address'
    Address.update_all(address_type: 'user_address')
  end

  def down
    remove_column :addresses, :address_type
  end
end
