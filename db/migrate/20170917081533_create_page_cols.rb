class CreatePageCols < ActiveRecord::Migration[5.1]
  def change
    create_table :page_cols do |t|
      t.belongs_to :page_row, foreign_key: true
      t.string :layout
      t.integer :index, default: 0

      t.timestamps
    end
    add_column :page_rows, :page_cols_count, :integer, default: 0
    add_column :pages, :page_rows_count, :integer, default: 0
  end
end
