# add access controll to all modules , can be deleted
class AddShowToToPageColModules < ActiveRecord::Migration[5.1]
  def up
    add_column :page_col_modules, :access_to, :string, default: 'all'
  end

  def down
    remove_column :page_col_modules, :access_to
  end
end
