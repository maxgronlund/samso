class AddLegacyIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :legacy_id, :integer
  end
end
