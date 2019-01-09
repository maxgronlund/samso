class CreateServiceFunctionsPrintedAds < ActiveRecord::Migration[5.2]
  def change
    create_table :service_functions_printed_ads do |t|
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
      t.string :state, default: 'pending'

      t.timestamps
    end
  end
end
