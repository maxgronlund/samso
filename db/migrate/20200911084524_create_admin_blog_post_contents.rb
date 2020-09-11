class CreateAdminBlogPostContents < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_blog_post_contents do |t|
      t.string :layout, default: "image_top"
      t.text :body
      t.string :image_caption
      t.text :video_url, default: ""
      t.integer :position
      t.belongs_to :admin_blog_post, null: false, foreign_key: true

      t.timestamps
    end

    add_attachment :admin_blog_post_contents, :image
  end
end