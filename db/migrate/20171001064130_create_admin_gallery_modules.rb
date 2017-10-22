# gallery module
class CreateAdminGalleryModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_gallery_modules do |t|
      t.string :name
      t.text :body
      t.string :layout
      t.integer :page_id
      t.string :color, default: '#000000'
      t.string :background_color, default: '#FFFFFF'
      t.integer :gallery_images_count, default: 0
      t.integer :images_pr_page, default: 16

      t.timestamps
    end
    add_index :admin_gallery_modules, :page_id
    add_module_name
  end

  def down
    drop_table :admin_gallery_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::GalleryModule', locale: 'admin/gallery_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::GalleryModule')
    module_name.delete unless module_name.nil?
  end
end
