class DropAddressesOld < ActiveRecord::Migration[5.2]
  def up
    # drop_table :subscription_addresses
    drop_table :addresses_old
  end

  def down
    create_table :addresses_old do |t|
      t.string :name
    end
  end
end
