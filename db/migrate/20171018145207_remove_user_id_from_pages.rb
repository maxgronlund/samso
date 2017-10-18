# delete this
class RemoveUserIdFromPages < ActiveRecord::Migration[5.1]
  def up
    remove_column :pages, :user_id
    remove_column :pages, :require_subscription
  end

  def down
    add_column :pages, :user_id, :integer
    add_column :pages, :require_subscription, default: false
  end
end
