class AddStateToAdminSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_subscriptions, :state, :string, default: 'pending'
  end
end
