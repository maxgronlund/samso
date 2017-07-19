# flag fo pages that requires subscriptions
class AddPermissionToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :require_subscription, :boolean, default: false
  end
end
