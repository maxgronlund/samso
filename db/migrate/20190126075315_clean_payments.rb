class CleanPayments < ActiveRecord::Migration[5.2]
  def up
    remove_column :payments, :name
    remove_column :payments, :address
    remove_column :payments, :postal_code_and_city
    remove_column :payments, :subscription_id
  end

  def down
    add_column :payments, :name, :string
    add_column :payments, :address, :string
    add_column :payments, :postal_code_and_city, :string
    add_column :payments, :subscription_id, :integer
  end
end
