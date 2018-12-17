class UpdateAddressType < ActiveRecord::Migration[5.2]
  def up
    change_column :addresses, :address_type, :string, default: 'primary_address'
    Address.update_all(address_type: 'primary_address')
  end

  def down
    change_column :addresses, :address_type, :string, default: 'user_address'
  end
end
