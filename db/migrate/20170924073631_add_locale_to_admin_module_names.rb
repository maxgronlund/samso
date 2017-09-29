# translation key for modules
class AddLocaleToAdminModuleNames < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_module_names, :locale, :string
    add_column :admin_module_names, :position, :integer
  end
end
