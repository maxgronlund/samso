class AddStreetNameToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :first_name, :string
    add_column :addresses, :middle_name, :string
    add_column :addresses, :last_name, :string
    add_column :addresses, :street_name, :string
    add_column :addresses, :house_number, :integer
    add_column :addresses, :letter, :string
    add_column :addresses, :floor, :string
    add_column :addresses, :side, :string
  end
end
