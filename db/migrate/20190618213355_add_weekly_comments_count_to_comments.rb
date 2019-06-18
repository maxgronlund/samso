class AddWeeklyCommentsCountToComments < ActiveRecord::Migration[5.2]
  def up
    add_column :comments, :weekly_comments_count, :integer, default: 0
    migrate_weekly_comments
  end

  def down
    remove_column :comments, :weekly_comment_count
  end

  private

  def migrate_weekly_comments

    Comment.find_each do |comment|
      count = comment.weekly_comments.count
      next if count.zero?
      comment.update(weekly_comments_count: count)
    end
  end
end
