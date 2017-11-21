# temp relation
class AddCategoryIdToAdminBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blogs, :category_id, :integer
    add_index :admin_blogs, :category_id
  end
end
