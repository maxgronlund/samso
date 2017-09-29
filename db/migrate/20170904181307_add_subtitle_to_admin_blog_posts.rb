# subtitles on blog_post
class AddSubtitleToAdminBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :subtitle, :text
  end
end
