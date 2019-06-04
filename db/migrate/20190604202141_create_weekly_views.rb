class CreateWeeklyViews < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_views do |t|
      t.belongs_to :blog_post_stat, foreign_key: true

      t.timestamps
    end

    add_column :blog_post_stats, :weekly_views_count, :integer, default: 0
  end
end
