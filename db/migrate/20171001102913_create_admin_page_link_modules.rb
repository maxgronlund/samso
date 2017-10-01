# Module for new feature
class CreateAdminPageLinkModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_page_link_modules do |t|
      t.string :name

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::PageLink')
      .first_or_create(
        name: 'Admin::PageLinkModule',
        locale: 'admin/page_link_module.name'
      )
  end

  def down
    drop_table :admin_page_link_modules

    Admin::ModuleName
      .where(name: 'Admin::PageLinkModule')
      .delete_all
  end
end
