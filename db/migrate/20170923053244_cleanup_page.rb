# remove unused fields from the page
class CleanupPage < ActiveRecord::Migration[5.1]
  def up
    remove_column :pages, :color_row_1
    remove_column :pages, :row_1_padding_top
    remove_column :pages, :color_row_2
    remove_column :pages, :row_2_padding_top
    remove_column :pages, :color_row_3
    remove_column :pages, :row_3_padding_top
    remove_attachment :pages, :row_1_background
    remove_attachment :pages, :row_2_background
    remove_attachment :pages, :row_3_background
    remove_column :pages, :row_1_padding_bottom
    remove_column :pages, :row_2_padding_bottom
    remove_column :pages, :row_3_padding_bottom
    remove_column :pages, :layout
  end

  def down
    add_column :pages, :color_row_1, :string
    add_column :pages, :row_1_padding_top, :integer, default: 0
    add_column :pages, :color_row_2, :string
    add_column :pages, :row_2_padding_top, :integer, default: 0
    add_column :pages, :color_row_3, :string
    add_column :pages, :row_3_padding_top, :integer, default: 0
    add_attachment :pages, :row_1_background
    add_attachment :pages, :row_2_background
    add_attachment :pages, :row_3_background
    add_column :pages, :row_1_padding_bottom, :integer, default: 0
    add_column :pages, :row_2_padding_bottom, :integer, default: 0
    add_column :pages, :row_3_padding_bottom, :integer, default: 0
    add_column :pages, :layout, :string
  end
end
