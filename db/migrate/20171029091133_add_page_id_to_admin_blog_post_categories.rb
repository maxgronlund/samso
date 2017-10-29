class AddPageIdToAdminBlogPostCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_post_categories, :page_id, :integer
    add_index :admin_blog_post_categories, :page_id
  end
end
