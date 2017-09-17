class CreatePageColModules < ActiveRecord::Migration[5.1]
  def change
    create_table :page_col_modules do |t|
      t.belongs_to :page_col, foreign_key: true
      t.references :moduleable, polymorphic: true
      t.integer :position

      t.timestamps
    end
  end
end
