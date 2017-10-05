# Module for new feature
class CreateAdminVerticalMenuModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_vertical_menu_modules do |t|
      t.string :name
      t.integer :vertical_menu_content_id

      t.timestamps
    end
    add_index :admin_vertical_menu_modules, :vertical_menu_content_id
    Admin::ModuleName
      .where(name: 'Admin::VerticalMenu')
      .first_or_create(
        name: 'Admin::VerticalMenuModule',
        locale: 'admin/vertical_menu_module.name'
      )
  end

  def down
    drop_table :admin_vertical_menu_modules

    Admin::ModuleName
      .where(name: 'Admin::VerticalMenuModule')
      .delete_all
  end
end
