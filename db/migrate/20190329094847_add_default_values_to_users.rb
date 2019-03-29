class AddDefaultValuesToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :name, :string, default: ''
    change_column :users, :signature, :string, default: ''
  end

  def down
    change_column :users, :name, :string, default: nil
    change_column :users, :signature, :string, default: nil
  end
end
