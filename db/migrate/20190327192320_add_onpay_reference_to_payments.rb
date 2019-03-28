class AddOnpayReferenceToPayments < ActiveRecord::Migration[5.2]
  def up
    add_column :payments, :onpay_reference, :string, default: 'na'

    Payment.find_each do |payment|
      if payment.onpay_reference == 'na'
        onpay_reference = 'SP-' + (payment.id + 8000).to_s
        payment.update(onpay_reference: onpay_reference)
      end
    end
  end

  def down
    remove_column :payments, :onpay_reference
  end
end
