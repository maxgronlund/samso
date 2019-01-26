class AddPayableToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :payable_id, :integer
    add_reference :payments, :payable_type, :string
  end
end
