class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :body
      t.text :identifier
      t.integer :position
      t.references :contentable, polymorphic: true

      t.timestamps
    end
  end
end
