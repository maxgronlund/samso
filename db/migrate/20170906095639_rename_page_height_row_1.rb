# make margins top and buttom ajustable
class RenamePageHeightRow1 < ActiveRecord::Migration[5.1]
  def up
    rename_column :pages, :height_row_1, :row_1_padding_top
    rename_column :pages, :height_row_2, :row_2_padding_top
    rename_column :pages, :height_row_3, :row_3_padding_top

    change_column :pages, :row_1_padding_top, :integer, default: 0
    change_column :pages, :row_2_padding_top, :integer, default: 0
    change_column :pages, :row_3_padding_top, :integer, default: 0

    add_column :pages, :row_1_padding_bottom, :integer, default: 0
    add_column :pages, :row_2_padding_bottom, :integer, default: 0
    add_column :pages, :row_3_padding_bottom, :integer, default: 0
  end

  def down
    rename_column :pages, :row_1_padding_top, :height_row_1
    rename_column :pages, :row_2_padding_top, :height_row_2
    rename_column :pages, :row_3_padding_top, :height_row_3

    remove_column :pages, :row_1_padding_bottom
    remove_column :pages, :row_2_padding_bottom
    remove_column :pages, :row_3_padding_bottom
  end
end
