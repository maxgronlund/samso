class AddShowAllCategoriesToAdminBlogModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_modules, :show_all_categories, :boolean, default: false
    add_column :admin_blog_modules, :featured_posts_pr_page, :integer, default: 0
  end
end
