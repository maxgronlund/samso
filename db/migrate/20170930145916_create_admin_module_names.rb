# list of available names
class CreateAdminModuleNames < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_module_names do |t|
      t.string :name
      t.string :locale
      t.integer :position

      t.timestamps
    end
  end
end
