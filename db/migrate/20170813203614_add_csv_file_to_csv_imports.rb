# File to parse
class AddCsvFileToCsvImports < ActiveRecord::Migration[5.1]
  def up
    add_attachment :admin_csv_imports, :csv_file, :string
  end

  def down
    remove_attachment :admin_csv_imports, :csv_file, :string
  end
end
