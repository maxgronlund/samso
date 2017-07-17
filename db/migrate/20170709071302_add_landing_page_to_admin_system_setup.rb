# set root_path from admin system
class AddLandingPageToAdminSystemSetup < ActiveRecord::Migration[5.1]
  def up
    add_column :admin_system_setups, :da_landing_page_id, :integer
    add_column :admin_system_setups, :en_landing_page_id, :integer
  end

  def down
    remove_column :admin_system_setups, :da_landing_page_id
    remove_column :admin_system_setups, :en_landing_page_id
  end
end
