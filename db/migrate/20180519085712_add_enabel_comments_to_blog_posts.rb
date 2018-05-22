class AddEnabelCommentsToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :enable_comments, :boolean, default: false
  end
end
