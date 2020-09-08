# frozen_string_literal: true

# blog posts
class CreateAdminBlogPosts < ActiveRecord::Migration[5.1]
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def up
    create_table :admin_blog_posts do |t|
      t.integer :legacy_id
      t.string :title
      t.string :layout, default: 'image_top'
      t.text :subtitle
      t.text :teaser
      t.text :body
      t.integer :position
      t.integer :blog_id
      t.boolean :free_content, default: false
      t.boolean :featured, default: false
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :user, foreign_key: false
      t.integer :views, default: 0
      t.string :signature, default: ''
      t.integer :post_page_id

      t.timestamps
    end
    add_index :admin_blog_posts, :blog_id
    add_index :admin_blog_posts, :post_page_id
    add_attachment :admin_blog_posts, :image

    add_column :users, :blog_posts_count, :integer, default: 0
    add_column :admin_blogs, :blog_posts_count, :integer, default: 0
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def down
    drop_table :admin_blog_posts
    remove_column :users, :blog_posts_count
    remove_column :admin_blogs, :blog_posts_count
  end
end
