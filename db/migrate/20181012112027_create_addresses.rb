class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.string :address
      t.integer :zipp_code
      t.string :city

      t.timestamps
    end
  end
end
