# Join model between editable section and a page
class CreatePageModules < ActiveRecord::Migration[5.1]
  def change
    create_table :page_modules do |t|
      t.belongs_to :page, foreign_key: true
      t.references :moduleable, polymorphic: true
      t.integer :slot_id
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
