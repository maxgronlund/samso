# frozen_string_literal: true

# link
class AddVidioUrlToAdminBlogPostModules < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_blog_posts, :video_url, :text, default: ''
  end
end
