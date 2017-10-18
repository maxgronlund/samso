class RemoveUserIdFromPages < ActiveRecord::Migration[5.1]
  def up
    remove_column :pages, :user_id
  end

  def down
    add_column :pages, :user_id, :integer
  end
end
