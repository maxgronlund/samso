class RunCreateBlogPostStats < ActiveRecord::Migration[5.2]
  def up
    Rake::Task['blog_posts:create_blog_post_stats'].invoke
  end

  def down
  end
end
