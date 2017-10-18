# to be deleted
class CleanupPayments < ActiveRecord::Migration[5.1]
  def up
    remove_column :payments, :password
    remove_column :payments, :password_confirmation
    remove_column :payments, :news_letter
    remove_column :payments, :email
  end

  def down
    add_column :payments, :password, :string
    add_column :payments, :password_confirmation, :string
    add_column :payments, :news_letter, :boolean
    add_column :payments, :email, :string
  end
end
