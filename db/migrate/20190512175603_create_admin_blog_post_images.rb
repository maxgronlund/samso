class CreateAdminBlogPostImages < ActiveRecord::Migration[5.2]
  def up
    create_table :admin_blog_post_images do |t|
      t.string :image_caption
      t.belongs_to :admin_blog_post, foreign_key: true
      t.integer :position

      t.timestamps
    end

    add_attachment :admin_blog_post_images, :image
  end

  def down
    drop_table :admin_blog_post_images
  end
end
