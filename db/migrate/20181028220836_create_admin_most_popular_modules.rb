# Module for new feature
class CreateAdminMostPopularModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_most_popular_modules do |t|
      t.string :name

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::MostPopular')
      .first_or_create(
        name: 'Admin::MostPopularModule',
        locale: 'admin/most_popular_module.name'
      )
  end

  def down
    drop_table :admin_most_popular_modules

    Admin::ModuleName
      .where(name: 'Admin::MostPopularModule')
      .delete_all
  end
end
