# frozen_string_literal: true

# so we can have imported subscriptions
class AddIdentifierToAdminSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_subscription_types, :identifier, :string, default: 'internal'
  end
end
