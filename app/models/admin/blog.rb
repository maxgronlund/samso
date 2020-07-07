# frozen_string_literal: true

# a blog to embed inside the BlogModule
class Admin::Blog < ApplicationRecord
  has_many :posts, class_name: 'Admin::BlogPost', dependent: :destroy

  def show_page
    Page.find(show_page_id)
  rescue => e
    nil
  end

  def index_page
    Page.find(index_page_id)
  rescue => e
    nil
  end

  def clear_page_cache
    Admin::BlogModule.find_each(&:touch)
    Admin::FeaturedPostModule.find_each(&:touch)
  end

  # Admin::Blog.update_all_counts
  def self.update_all_counts
    all.each do |blog|
      Admin::Blog.reset_counters(blog.id, :posts)
    end
  end
end
