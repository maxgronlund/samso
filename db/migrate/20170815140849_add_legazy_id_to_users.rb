# tempory column used for import of legacy data
class AddLegazyIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :legacy_id, :integer
  end
end
