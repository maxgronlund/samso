class AddCounterCacheToAdminGaleryModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_gallery_modules, :gallery_images_count, :integer, default: 0
  end
end
