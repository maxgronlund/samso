# limit to one category
class AddBlogIdToFeaturedPostModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_featured_post_modules, :blog_id, :integer
    add_index :admin_featured_post_modules, :blog_id
  end
end
