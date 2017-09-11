class AddStartDateToAdminBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :start_date, :datetime
    add_column :admin_blog_posts, :end_date, :datetime
  end
end
