class CreateAdminNewsletterPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_newsletter_posts do |t|
      t.belongs_to :admin_blog_post, foreign_key: true
      t.belongs_to :admin_newsletter, foreign_key: true

      t.timestamps
    end
  end
end
