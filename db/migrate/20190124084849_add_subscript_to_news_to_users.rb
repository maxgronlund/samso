class AddSubscriptToNewsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscript_to_news, :boolean, default: false
  end
end
