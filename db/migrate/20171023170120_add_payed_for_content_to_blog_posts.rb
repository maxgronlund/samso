class AddPayedForContentToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :layout, :string, default: 'image_top'
    add_column :admin_blog_posts, :free_content, :boolean, default: false
    add_column :admin_blog_posts, :featured, :boolean, default: false
  end
end
