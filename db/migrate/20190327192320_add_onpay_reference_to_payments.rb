class AddOnpayReferenceToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :onpay_reference, :string, default: 'na'
  end
end
