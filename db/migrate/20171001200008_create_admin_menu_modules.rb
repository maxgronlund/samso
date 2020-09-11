# frozen_string_literal: true

# Module for new feature
class CreateAdminMenuModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_menu_modules do |t|
      t.string :name
      t.integer :menu_content_id
      t.string :layout, default: 'vertical'

      t.timestamps
    end
    add_index :admin_menu_modules, :menu_content_id
    Admin::ModuleName
      .where(name: 'Admin::Menu')
      .first_or_create(
        name: 'Admin::MenuModule',
        locale: 'admin/menu_module.name'
      )
  end

  def down
    drop_table :admin_menu_modules

    Admin::ModuleName
      .where(name: 'Admin::MenuModule')
      .delete_all
  end
end
