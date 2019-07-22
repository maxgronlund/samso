class AddOrderCompletedEmailToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :order_completed_email, :string
  end
end
