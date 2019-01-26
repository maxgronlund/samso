class AddTransactionInfoToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :transaction_info, :hstore, default: {}, null: false
    add_column :payments, :payment_provider, :string
  end
end
