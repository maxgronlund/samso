# frozen_string_literal: true

class AddEnabelCommentsToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_blog_posts, :enable_comments, :boolean, default: false
  end
end
