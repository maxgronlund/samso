# settings for the TextModule
class AddBordersToTextModules < ActiveRecord::Migration[5.1]
  def change
    add_column :text_modules, :border, :boolean, default: false
    add_column :text_modules, :image_style, :string, default: 'full-width'
    remove_column :text_modules, :layout, :string
  end
end
