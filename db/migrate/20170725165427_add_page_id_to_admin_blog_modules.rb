# page to show a blog_post on
class AddPageIdToAdminBlogModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_modules, :post_page_id, :integer
    add_index :admin_blog_modules, :post_page_id
  end
end
