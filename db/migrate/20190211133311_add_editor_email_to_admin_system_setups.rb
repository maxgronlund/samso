class AddEditorEmailToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :editor_emails, :string, default: ''
  end
end
