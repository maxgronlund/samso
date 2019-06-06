class CreateWeeklyComments < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_comments do |t|
      t.belongs_to :comment, foreign_key: true

      t.timestamps
    end
    add_column :blog_post_stats, :weekly_comments_count, :integer, default: 0
  end
end
