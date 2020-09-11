# frozen_string_literal: true

# Module for new feature
class CreateAdminFindBlogPostModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_find_blog_post_modules do |t|
      t.string :name
      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::FindBlogPost')
      .first_or_create(
        name: 'Admin::FindBlogPostModule',
        locale: 'admin/find_blog_post_module.name'
      )
  end

  def down
    drop_table :admin_find_blog_post_modules

    Admin::ModuleName
      .where(name: 'Admin::FindBlogPostModule')
      .delete_all
  end
end
