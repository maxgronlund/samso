class RecreateAddresses < ActiveRecord::Migration[5.2]
def up
    rename_table :addresses, :addresses_old
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :name
      t.string :address
      t.integer :zipp_code
      t.string :city
      t.string :address_type, default: "primary_address"
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def down
    drop_table :addresses
    rename_table :addresses_old, :addresses
  end
end
