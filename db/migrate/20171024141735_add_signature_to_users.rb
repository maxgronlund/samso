class AddSignatureToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :signature, :string
    copy_name_to_signature
  end

  def down
    remove_column :users, :signature, :string
  end

  private

  def copy_name_to_signature
    User.find_each do |user|
      user.update_attributes(signature: user.name)
    end
  end
end
