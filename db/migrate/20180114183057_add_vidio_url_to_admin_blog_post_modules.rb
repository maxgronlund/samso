# link
class AddVidioUrlToAdminBlogPostModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :video_url, :text, default: ''
  end
end
