class AddAdministratorEmailToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :administrator_email, :string
  end
end
