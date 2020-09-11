# frozen_string_literal: true

# so we can have free subscriptions
class AddFreeToAdminSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_subscription_types, :free, :boolean, default: false
  end
end
