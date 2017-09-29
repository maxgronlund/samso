# Move textmodule under admin namespace
class RemoveAdminNamespaceFromModules < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :text_modules, :admin_text_modules
  end

  def self.down
    rename_table :admin_text_modules, :text_modules
  end
end
