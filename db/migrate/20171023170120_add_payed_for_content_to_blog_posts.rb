class AddPayedForContentToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :free_content, :boolean, default: false
  end
end
