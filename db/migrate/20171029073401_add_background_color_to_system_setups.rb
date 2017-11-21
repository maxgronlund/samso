# Styling of the menubar
class AddBackgroundColorToSystemSetups < ActiveRecord::Migration[5.1]
  def up
    add_column :admin_system_setups, :background_color, :string, default: 'none'
    add_attachment :admin_system_setups, :logo
  end

  def down
    remove_column :admin_system_setups, :background_color, :string
    remove_attachment :admin_system_setups, :logo
  end
end
