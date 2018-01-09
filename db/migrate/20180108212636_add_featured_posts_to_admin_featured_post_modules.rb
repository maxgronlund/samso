class AddFeaturedPostsToAdminFeaturedPostModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_featured_post_modules, :featured_posts_pr_page, :integer, default: 16
    rename_column :admin_featured_post_modules, :name, :title
  end
end
