# controll to whoom a text section is shown
class AddShowToAdminTextModules < ActiveRecord::Migration[5.1]
  def up
    add_column :text_modules, :show_to, :string, defalut: 'all'
    TextModule.update_all(show_to: 'all')
  end

  def down
    remove_column :text_modules, :show_to, :string
  end
end
