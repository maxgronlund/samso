# privent import same legacy data more than once
class AddLegacyIdToAdminBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_posts, :legacy_id, :integer
  end
end
