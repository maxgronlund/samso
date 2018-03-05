# so we can have imported subscriptions
class AddIdentifierToAdminSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscription_types, :identifier, :string, default: 'internal'
  end
end
