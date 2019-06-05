class AddAuthorNameToComments < ActiveRecord::Migration[5.2]
  def up
    add_column :comments, :author_name, :string, default: ''
    add_column :comments, :state, :string, default: 'default'
    update_author_name
  end

  def down
    remove_column :comments, :author_name
    remove_column :comments, :state
  end

  private

  def update_author_name
    Comment.find_each do |comment|
      comment.update(author_name: comment.user.name)
    end
  end
end
