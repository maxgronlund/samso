# frozen_string_literal: true

# Module for new feature
class CreateAdminYoutubeModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_youtube_modules do |t|
      t.string :name
      t.text :snippet

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::Youtube')
      .first_or_create(
        name: 'Admin::YoutubeModule',
        locale: 'admin/youtube_module.name'
      )
  end

  def down
    drop_table :admin_youtube_modules

    Admin::ModuleName
      .where(name: 'Admin::YoutubeModule')
      .delete_all
  end
end
