class AddGroupToAdminSubscriptionType < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_subscription_types, :group, :string, default: 'Abonnement'
  end
end
