# Dropdown link to pages
class AddPageIdToTextModuels < ActiveRecord::Migration[5.1]
  def change
    add_column :text_modules, :page_id, :integer
    add_index :text_modules, :page_id
  end
end
