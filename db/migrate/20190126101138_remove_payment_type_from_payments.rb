class RemovePaymentTypeFromPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :payments, :payment_type, :string
    remove_column :payments, :payment_id, :integer
  end
end
