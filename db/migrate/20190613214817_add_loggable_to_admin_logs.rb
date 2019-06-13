class AddLoggableToAdminLogs < ActiveRecord::Migration[5.2]
  def up

    add_column :admin_logs, :loggable_id, :integer
    add_column :admin_logs, :loggable_type, :string
    update_admin_logs
  end

  def down
    remove_column :admin_logs, :loggable_id
    remove_column :admin_logs, :loggable_type
  end

  private

  def update_admin_logs
    Admin::Log.find_each do |admin_log|
      payment = Payment.find_by(onpay_reference: admin_log.title)
      next if payment.nil?

      admin_log.update(loggable_id: payment.id, loggable_type: payment.class.name)
    end
  end
end
