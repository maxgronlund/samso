# Gallery module
class CreateAdminGalleryModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_gallery_modules do |t|
      t.string :name
      t.text :body
      t.string :layout

      t.timestamps
    end
  end
end
