class AddAuthTokenToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :auth_token, :string
    update_existing_users
  end

  def down
    remove_column :users, :auth_token
  end

  private

  def update_existing_users
    User.find_each do |user|
      user.generate_token(:auth_token)
      user.save
    end
  end
end
