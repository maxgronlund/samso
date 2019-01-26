class RenameColumnSubscriptToNews < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :subscript_to_news, :subscribe_to_news
  end
end
