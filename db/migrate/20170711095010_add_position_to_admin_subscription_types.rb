# sort subscription types
class AddPositionToAdminSubscriptionTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscription_types, :position, :integer, default: 0
  end
end
