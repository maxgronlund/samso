# import of csv file
class CreateAdminCsvImports < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_csv_imports do |t|
      t.string :name
      t.string :import_type
      t.text :comments
      t.text :summary

      t.timestamps
    end
  end
end
