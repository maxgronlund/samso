# frozen_string_literal: true

# Module for new feature
class CreateAdminSearchResultModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_search_result_modules do |t|
      t.string :name

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::SearchResult')
      .first_or_create(
        name: 'Admin::SearchResultModule',
        locale: 'admin/search_result_module.name'
      )
  end

  def down
    drop_table :admin_search_result_modules

    Admin::ModuleName
      .where(name: 'Admin::SearchResultModule')
      .delete_all
  end
end
