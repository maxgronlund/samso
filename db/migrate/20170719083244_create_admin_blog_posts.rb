# Post for the blog
class CreateAdminBlogPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_blog_posts do |t|
      t.string :title
      t.text :body
      t.integer :position
      t.integer :blog_module_id

      t.timestamps
    end

    add_index :admin_blog_posts, :blog_module_id
  end
end
