# List of module names
class CreateAdminModuleNames < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_module_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
