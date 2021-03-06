# frozen_string_literal: true

# coll bootstrap style
class CreatePageCols < ActiveRecord::Migration[6.0]
  def change
    create_table :page_cols do |t|
      t.belongs_to :page_row, foreign_key: true
      t.string :layout
      t.integer :index, default: 0

      t.timestamps
    end
  end
end
