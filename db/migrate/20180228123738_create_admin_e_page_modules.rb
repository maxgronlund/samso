# frozen_string_literal: true

# Module for new feature
class CreateAdminEPageModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_e_page_modules do |t|
      t.string :title
      t.text :body
      t.string :link
      t.string :image_link
      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::EPage')
      .first_or_create(
        name: 'Admin::EPageModule',
        locale: 'admin/e_page_module.name'
      )
  end

  def down
    drop_table :admin_e_page_modules

    Admin::ModuleName
      .where(name: 'Admin::EPageModule')
      .delete_all
  end
end
