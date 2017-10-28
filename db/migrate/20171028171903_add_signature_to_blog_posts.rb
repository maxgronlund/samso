# Cache signature on blog posts
class AddSignatureToBlogPosts < ActiveRecord::Migration[5.1]
  def up
    add_column :admin_blog_posts, :signature, :string, default: ''
    copy_name_to_signature
  end

  def down
    remove_column :admin_blog_posts, :signature, :string
  end

  def copy_name_to_signature
    Admin::BlogPost.find_each do |blog_post|
      next if blog_post.signature.empty?
      user = blog_post.user
      next if user.nil?
      blog_post.update_attributes(signature: user.signature)
    end
  end
end
