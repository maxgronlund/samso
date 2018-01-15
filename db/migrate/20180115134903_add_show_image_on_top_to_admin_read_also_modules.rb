class AddShowImageOnTopToAdminReadAlsoModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_read_also_modules, :image_on_top, :boolean, default: false
  end
end
