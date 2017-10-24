class CreateAdminBlogPostCategories < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_blog_post_categories do |t|
      t.string :locale, default: 'en'
      t.string :name, default: ''
      t.boolean :active, default: true
      t.integer :legacy_id
      t.integer :blog_post_count

      t.timestamps
    end

    add_column :admin_blog_posts, :admin_blog_post_category_id, :integer
    add_index :admin_blog_posts, :admin_blog_post_category_id
  end

  def down
    drop_table :admin_blog_post_categories
    remove_column :admin_blog_posts, :admin_blog_post_category_id
  end
end
