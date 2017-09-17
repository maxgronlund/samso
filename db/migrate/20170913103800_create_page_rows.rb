# Rows on pages
class CreatePageRows < ActiveRecord::Migration[5.1]
  def change
    create_table :page_rows do |t|
      t.belongs_to :page, foreign_key: true
      t.string :layout, default: '12'
      t.string :background_color, default: 'none'
      t.integer :padding_top, default: 0
      t.integer :padding_bottom, default: 0
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
