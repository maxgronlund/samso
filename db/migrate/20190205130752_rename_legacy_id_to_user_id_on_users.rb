class RenameLegacyIdToUserIdOnUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :legacy_id, :user_id
  end
end
