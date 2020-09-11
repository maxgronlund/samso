# Module for new feature
class CreateAdminIframeModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_iframe_modules do |t|
      t.string :name
      t.text :snippet

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::Iframe')
      .first_or_create(
        name: 'Admin::IframeModule',
        locale: 'admin/iframe_module.name'
      )
  end

  def down
    drop_table :admin_iframe_modules

    Admin::ModuleName
      .where(name: 'Admin::IframeModule')
      .delete_all
  end
end
