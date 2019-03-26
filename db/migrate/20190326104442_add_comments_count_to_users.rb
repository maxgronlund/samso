class AddCommentsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :comments_count, :integer, default: 0

    Comment.find_each do |comment|
      user = comment.user
      user.update(comments_count: user.comments_count + 1) if user.present?
    end

    # User.all.each do |user|
    #   user.update_attribute :comments_count, p.comments.length
    # end
  end
end
