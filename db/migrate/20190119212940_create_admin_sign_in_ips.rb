class CreateAdminSignInIps < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_sign_in_ips do |t|
      t.inet :ip
      t.datetime :sign_in_at
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
