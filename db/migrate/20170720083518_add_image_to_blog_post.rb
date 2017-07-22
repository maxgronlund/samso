# image on a post in the blog
class AddImageToBlogPost < ActiveRecord::Migration[5.1]
  def up
    add_attachment :admin_blog_posts, :image
  end

  def down
    remove_attachment :admin_blog_posts, :image
  end
end
