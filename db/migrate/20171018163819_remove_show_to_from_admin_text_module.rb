# remove obsolete fields
class RemoveShowToFromAdminTextModule < ActiveRecord::Migration[5.1]
  def up
    remove_column :admin_text_modules, :show_to
    remove_column :admin_text_modules, :user_id
  end

  def down
    add_column :admin_text_modules, :show_to, :string, default: 'all'
    add_column :admin_text_modules, :user_id, :integer
  end
end
