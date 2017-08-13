# module for showing one image
class CreateAdminImageModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_image_modules do |t|
      t.string :layout
      t.timestamps
    end
  end
end
