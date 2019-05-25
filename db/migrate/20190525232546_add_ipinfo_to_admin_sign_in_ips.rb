class AddIpinfoToAdminSignInIps < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_sign_in_ips, :ipinfo, :hstore, default: {}, null: false
  end
end
