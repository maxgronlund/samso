# frozen_string_literal: true

# a blog to embed inside the BlogModule
class Admin::Blog < ApplicationRecord
  # has_one :page, class_name: 'Page', dependent: :nullify
  has_one :page, class_name: 'Page', dependent: :nullify
  has_many :posts, class_name: 'Admin::BlogPost', dependent: :destroy
  def clear_page_cache
    blog_modules = Admin::BlogModule.where(admin_blog_id: id)
    blog_modules.each(&:clear_page_cache)
  end

  # Admin::Blog.update_all_counts
  def self.update_all_counts
    all.each do |blog|
      Admin::Blog.reset_counters(blog.id, :posts)
    end
  end
end
