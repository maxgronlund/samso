class ChangeZippCodeOnAddress < ActiveRecord::Migration[5.2]
  def up
    change_column :addresses, :zipp_code, :string, default: ''
  end

  def down
    change_column :addresses, :zipp_code, :integer
  end
end
