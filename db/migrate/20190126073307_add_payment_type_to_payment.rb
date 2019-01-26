class AddPaymentTypeToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :payment_type, :string
    add_column :payments, :payment_id, :integer
  end
end
