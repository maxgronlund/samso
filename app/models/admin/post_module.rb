# module for showning a post from the blog on a page
class Admin::PostModule < ApplicationRecord
  include PageColConcerns
  has_many :page_col_modules, as: :moduleable

  def title(blog_post_id)
    return 'No posts' unless blog_post(blog_post_id)
    blog_post(blog_post_id).title
  end

  def body(blog_post_id)
    return '' unless blog_post(blog_post_id)
    blog_post(blog_post_id).body
  end

  def image_url(blog_post_id)
    return '' unless blog_post(blog_post_id)
    blog_post(blog_post_id).image.url(:medium)
  end

  def blog_module_page(blog_post_id)
    blog_post = blog_post(blog_post_id)
    return Page.first if blog_post.nil?
    blog_module = blog_post.blog_module
    blog_module.page
  end

  private

  def blog_post(blog_post_id)
    @blog_post ||= Admin::BlogPost.find_by(id: blog_post_id)
    return @blog_post unless @blog_post.nil?
    Admin::BlogPost.last
  end
end
