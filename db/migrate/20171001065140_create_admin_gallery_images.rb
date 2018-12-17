# frozen_string_literal: true

# an image that fits in to the gallery
class CreateAdminGalleryImages < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_gallery_images do |t|
      t.string :title
      t.text :body
      t.integer :gallery_module_id
      t.belongs_to :user
      t.integer :position

      t.timestamps
    end
    add_index :admin_gallery_images, :gallery_module_id
    add_attachment :admin_gallery_images, :image
  end

  def down
    drop_table :admin_gallery_images
  end
end
