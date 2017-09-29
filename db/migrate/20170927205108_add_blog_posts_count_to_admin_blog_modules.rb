# counter_cache for blog module
class AddBlogPostsCountToAdminBlogModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_modules, :blog_posts_count, :integer, default: 0
    add_column :admin_blog_modules, :posts_pr_page, :integer, default: 12
  end
end
