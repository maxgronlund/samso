# frozen_string_literal: true

# generic csv importer
class CreateAdminCsvImports < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_csv_imports do |t|
      t.string :name
      t.string :import_type
      t.text :comments
      t.text :summary

      t.timestamps
    end
    add_attachment :admin_csv_imports, :csv_file
  end
end
