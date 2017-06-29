# rename table to avoid name clash wit mail sender
class RenameContentToPost < ActiveRecord::Migration[5.1]
  def up
    rename_table :contents, :posts
    rename_column :posts, :contentable_type, :postable_type
    rename_column :posts, :contentable_id, :postable_id
  end

  def down
    rename_table :posts, :contents
    rename_column :contents, :postable_type, :contentable_type
    rename_column :contents, :postable_id, :contentable_id
  end
end
