# module to show one image
class CreateAdminImageModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_image_modules do |t|
      t.string :layout

      t.timestamps
    end
    add_module_name
  end

  def down
    drop_table :admin_image_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::ImageModule', locale: 'admin/image_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::ImageModule')
    module_name.delete unless module_name.nil?
  end
end