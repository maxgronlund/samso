# Module for new feature
class CreateAdminFeaturedPostModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_featured_post_modules do |t|
      t.string :title
      t.integer :admin_blog_module_id
      t.integer :featured_posts_pr_page, default: 16

      t.timestamps
    end
    add_index :admin_featured_post_modules, :admin_blog_module_id
    Admin::ModuleName
      .where(name: 'Admin::FeaturedPost')
      .first_or_create(
        name: 'Admin::FeaturedPostModule',
        locale: 'admin/featured_post_module.name'
      )
  end

  def down
    drop_table :admin_featured_post_modules

    Admin::ModuleName
      .where(name: 'Admin::FeaturedPostModule')
      .delete_all
  end
end
