# Module for new feature
class CreateAdminEPageFreeModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_e_page_free_modules do |t|
      t.string :title
      t.text :body
      t.string :link
      t.string :image_link

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::EPageFree')
      .first_or_create(
        name: 'Admin::EPageFreeModule',
        locale: 'admin/e_page_free_module.name'
      )
  end

  def down
    drop_table :admin_e_page_free_modules

    Admin::ModuleName
      .where(name: 'Admin::EPageFreeModule')
      .delete_all
  end
end
