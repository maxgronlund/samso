# module that fits on ap page and represent one row
class CreatePageRowModules < ActiveRecord::Migration[5.1]
  def change
    create_table :page_row_modules do |t|
      t.belongs_to :page_row, foreign_key: true
      t.references :moduleable, polymorphic: true
      t.integer :slot_id
      t.integer :position

      t.timestamps
    end
  end
end
