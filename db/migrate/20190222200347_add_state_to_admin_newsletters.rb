class AddStateToAdminNewsletters < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_newsletters, :state, :string, default: 'pending'
  end
end
