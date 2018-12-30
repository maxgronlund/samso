class AddPositionToAdminMenuLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_menu_links, :position, :integer, default: 0
  end
end
