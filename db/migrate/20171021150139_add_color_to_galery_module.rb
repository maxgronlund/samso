# fix
class AddColorToGaleryModule < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_gallery_modules, :color, :string, default: '#000000'
    add_column :admin_gallery_modules, :background_color, :string, default: '#FFFFFF'
    add_column :admin_image_modules, :color, :string, default: '#000000'
    add_column :admin_image_modules, :background_color, :string, default: '#FFFFFF'
  end
end
