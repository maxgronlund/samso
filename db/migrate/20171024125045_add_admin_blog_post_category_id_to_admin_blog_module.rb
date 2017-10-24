# to delete
class AddAdminBlogPostCategoryIdToAdminBlogModule < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_modules, :admin_blog_post_category, :integer
  end
end
