# Image atachment for the galery image
class AddImageToAdminGalleryImages < ActiveRecord::Migration[5.1]
  def up
    add_attachment :admin_gallery_images, :image
  end

  def down
    remove_attachment :admin_gallery_images, :image
  end
end
