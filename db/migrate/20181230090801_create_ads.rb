class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.date :start_date
      t.integer :number_of_columns
      t.text :body
      t.text :comment
      t.string :name
      t.string :address
      t.string :zipp_code
      t.string :city
      t.string :email
      t.string :phone
      t.string :contact_person

      t.timestamps
    end
  end
end
