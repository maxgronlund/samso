# frozen_string_literal: true

# facebook comments
class AddFbSnippetToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :fb_snippet, :text, default: ''
    add_column :admin_blog_posts, :show_facebook_comments, :boolean, default: true
  end
end
