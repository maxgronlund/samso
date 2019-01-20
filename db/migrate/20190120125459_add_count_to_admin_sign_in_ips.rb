class AddCountToAdminSignInIps < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_sign_in_ips, :count, :integer, default: 1
  end
end
