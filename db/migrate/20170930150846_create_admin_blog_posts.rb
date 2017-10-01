# blog posts
class CreateAdminBlogPosts < ActiveRecord::Migration[5.1]
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def up
    create_table :admin_blog_posts do |t|
      t.integer :legacy_id
      t.string :title
      t.text :subtitle
      t.text :teaser
      t.text :body
      t.text :teaser
      t.integer :position
      t.integer :blog_module_id
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :user, foreign_key: false

      t.timestamps
    end
    add_index :admin_blog_posts, :blog_module_id
    add_attachment :admin_blog_posts, :image

    add_column :users, :blog_posts_count, :integer, default: 0
  end

  def down
    drop_table :admin_blog_posts
    remove_column :users, :blog_posts_count
  end
end
