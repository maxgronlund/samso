class AddSignInIpsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sign_in_ips_count, :integer, default: 0
  end
end
