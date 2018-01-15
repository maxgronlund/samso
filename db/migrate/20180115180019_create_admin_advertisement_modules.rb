# Module for new feature
class CreateAdminAdvertisementModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_advertisement_modules do |t|
      t.string :name

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::Advertisement')
      .first_or_create(
        name: 'Admin::AdvertisementModule',
        locale: 'admin/advertisement_module.name'
      )
  end

  def down
    drop_table :admin_advertisement_modules

    Admin::ModuleName
      .where(name: 'Admin::AdvertisementModule')
      .delete_all
  end
end
