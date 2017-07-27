# Image for the galery
class CreateAdminGalleryImages < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_gallery_images do |t|
      t.string :title
      t.text :body
      t.integer :gallery_module_id
      t.belongs_to :user
      t.integer :position

      t.timestamps
    end
    add_index :admin_gallery_images, :gallery_module_id
  end
end
