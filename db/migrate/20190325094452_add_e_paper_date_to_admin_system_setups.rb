class AddEPaperDateToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :e_pages_date, :string
  end
end
