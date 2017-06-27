# for system settings
class CreateAdminSystemSetups < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_system_setups do |t|
      t.boolean :maintenance

      t.timestamps
    end
  end
end
