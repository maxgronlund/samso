class AddImageCaptionToAdminBlogPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_blog_posts, :image_caption, :string
  end
end
