# Place any type of modules inside a pabe_col
class CreatePageColModules < ActiveRecord::Migration[5.1]
  def change
    create_table :page_col_modules do |t|
      t.belongs_to :page_col, foreign_key: true
      t.references :moduleable, polymorphic: true
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
