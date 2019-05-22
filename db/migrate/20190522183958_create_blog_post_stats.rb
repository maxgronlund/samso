class CreateBlogPostStats < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_post_stats do |t|
      t.belongs_to :admin_blog_post, foreign_key: true
      t.integer :views, default: 0
      t.datetime :start_date

      t.timestamps
    end
  end
end
