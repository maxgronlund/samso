# teaser on a bost in the blog
class AddTeaserToAdminBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :teaser, :text
  end
end
