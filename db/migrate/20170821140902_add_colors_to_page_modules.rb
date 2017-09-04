# fancy layout for pages
class AddColorsToPageModules < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :color_row_1, :string
    add_column :pages, :height_row_1, :integer
    add_column :pages, :color_row_2, :string
    add_column :pages, :height_row_2, :integer
    add_column :pages, :color_row_3, :string
    add_column :pages, :height_row_3, :integer
    add_attachment :pages, :row_1_background
    add_attachment :pages, :row_2_background
    add_attachment :pages, :row_3_background
  end
end
