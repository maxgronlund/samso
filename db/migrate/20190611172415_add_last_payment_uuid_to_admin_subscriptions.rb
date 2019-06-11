class AddLastPaymentUuidToAdminSubscriptions < ActiveRecord::Migration[5.2]
  def up
    add_column :admin_subscriptions, :last_payment_uuid, :uuid
    set_uuids
  end

  def down
    remove_column :admin_subscriptions, :last_payment_uuid
  end

  private

  def set_uuids
    Payment.find_each do |payment|
      payable = payment.payable
      next unless payable.is_a?(Admin::Subscription)

      payable.update(last_payment_uuid: payment.uuid)
    end
  end
end
