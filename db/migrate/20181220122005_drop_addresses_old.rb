class DropAddressesOld < ActiveRecord::Migration[5.2]
  def up
    drop_table :addresses_old
  end
end
