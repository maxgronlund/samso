# to remove
class AddLegacyIdToAdminBlogPostCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_post_categories, :legacy_id, :integer
    add_column :admin_blog_post_categories, :blog_post_count, :integer, default: 0
  end
end
