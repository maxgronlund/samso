# page to show posts
class AddPostPageToAdminSystemSetup < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_system_setups, :da_post_page_id, :integer
    add_column :admin_system_setups, :en_post_page_id, :integer
  end
end
