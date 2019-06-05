class AddAuthorNameToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :author_name, :string
    add_column :comments, :state, :string, default: 'default'
  end
end
