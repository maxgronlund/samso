class AddPayableToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :payable_id, :integer
    add_column :payments, :payable_type, :string
  end
end
