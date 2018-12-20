class RecreateAddresses < ActiveRecord::Migration[5.2]
def up
    rename_table :addresses, :addresses_old
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :name
      t.string :address
      t.integer :zipp_code
      t.string :city

      t.timestamps
    end
  end
end
