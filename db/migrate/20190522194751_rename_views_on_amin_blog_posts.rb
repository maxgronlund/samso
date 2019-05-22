class RenameViewsOnAminBlogPosts < ActiveRecord::Migration[5.2]
  def up
    rename_column :admin_blog_posts, :views, :obsolete_views
  end

  def down
    rename_column :admin_blog_posts, :obsolete_views, :views
  end
end
