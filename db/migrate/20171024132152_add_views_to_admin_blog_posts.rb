# to delete
class AddViewsToAdminBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :views, :integer, default: 0
  end
end
