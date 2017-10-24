# category
class Admin::BlogPostCategory < ApplicationRecord
  has_many :blog_posts, class_name: 'Admin::BlogPost'

  # usage Admin::BlogPostCategory.update_blog_post_count(old_category_id, new_category_id)
  def self.update_blog_post_count(old_category_id, new_category_id)
    update_category(old_category_id)
    update_category(new_category_id)
  end

  def self.update_category(category_id)
    return if category_id.nil?
    category = Admin::BlogPostCategory.find_by(id: category_id)
    return if category.nil?
    category.update_attributes(
      blog_post_count: Admin::BlogPost.where(admin_blog_post_category_id: category.id).count
    )
  end

  # Admin::BlogPostCategory.update_all_counts
  def self.update_all_counts
    all.each do |category|
      category.update_attributes(
        blog_post_count: Admin::BlogPost.where(admin_blog_post_category_id: category.id).count
      )
      ap category
    end
  end
end
