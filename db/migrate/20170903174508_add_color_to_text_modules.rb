# background color for textmodule
class AddColorToTextModules < ActiveRecord::Migration[5.1]
  def change
    add_column :text_modules, :color, :string, default: '#000000'
    add_column :text_modules, :background_color, :string, default: '#FFFFFF'
  end
end
