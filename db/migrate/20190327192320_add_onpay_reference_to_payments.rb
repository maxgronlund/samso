class AddOnpayReferenceToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :onpay_reference, :string, default: 'na'

    Payment.find_each do |payment|
      if payment.uuid.present? && payment.onpay_reference.blank?
        payment.update(onpay_reference: payment.uuid)
      end
    end
  end
end
