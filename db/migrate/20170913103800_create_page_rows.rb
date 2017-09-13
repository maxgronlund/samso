# Rows on pages
class CreatePageRows < ActiveRecord::Migration[5.1]
  def change
    create_table :page_rows do |t|
      t.belongs_to :page, foreign_key: true
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
