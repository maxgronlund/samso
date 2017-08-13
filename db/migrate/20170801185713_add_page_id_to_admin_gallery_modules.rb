# link a galery to an image view page
class AddPageIdToAdminGalleryModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_gallery_modules, :page_id, :integer
    add_index :admin_gallery_modules, :page_id
  end
end
