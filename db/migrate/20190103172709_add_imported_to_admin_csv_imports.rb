class AddImportedToAdminCsvImports < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_csv_imports, :imported, :datetime
  end
end
