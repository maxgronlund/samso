# frozen_string_literal: true

# ploymorphic joyn so modules can be inserted into a page_col
class CreatePageColModules < ActiveRecord::Migration[6.0]
  def change
    create_table :page_col_modules do |t|
      t.belongs_to :page_col, foreign_key: true
      t.references :moduleable, polymorphic: true
      t.integer :position, default: 0
      t.integer :margin_bottom, default: 20
      t.string :access_to, default: 'all'

      t.timestamps
    end
  end
end
