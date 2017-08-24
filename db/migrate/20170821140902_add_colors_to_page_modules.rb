# fancy layout for pages
class AddColorsToPageModules < ActiveRecord::Migration[5.1]
  def change
    add_column :page_modules, :color_row_1, :string
    add_column :page_modules, :color_row_2, :string
    add_column :page_modules, :color_row_3, :string
    add_attachment :page_modules, :row_1_background
    add_attachment :page_modules, :row_2_background
    add_attachment :page_modules, :row_3_background
  end
end
