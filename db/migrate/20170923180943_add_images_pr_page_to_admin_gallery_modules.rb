class AddImagesPrPageToAdminGalleryModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_gallery_modules, :images_pr_page, :integer, default: 16
  end
end
