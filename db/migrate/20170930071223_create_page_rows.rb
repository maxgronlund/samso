# frozen_string_literal: true

# bootstrap style rows
class CreatePageRows < ActiveRecord::Migration[6.0]
  def change
    create_table :page_rows do |t|
      t.belongs_to :page, foreign_key: true
      t.string :layout, default: '12'
      t.string :background_color, default: 'none'
      t.integer :padding_top, default: 0
      t.integer :padding_bottom, default: 0
      t.integer :position, default: 0

      t.string :background_image_file_name
      t.string :background_image_content_type
      t.integer :background_image_file_size
      t.datetime :background_image_updated_at
      t.integer :page_cols_count, default: 0

      t.timestamps
    end
  end
end
