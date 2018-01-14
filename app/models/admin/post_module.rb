# module for showning a post from the blog on a page
class Admin::PostModule < ApplicationRecord
  include PageColConcerns
  has_many :page_col_modules, as: :moduleable

  def title(blog_post_id)
    return 'No posts' unless blog_post(blog_post_id)
    blog_post(blog_post_id).title
  end

  def start_date(blog_post_id)
    return nil unless blog_post(blog_post_id)
    blog_post(blog_post_id).start_date
  end

  def signature(blog_post_id)
    return nil unless blog_post(blog_post_id)
    blog_post(blog_post_id).signature
  end

  def body(blog_post_id)
    return '' unless blog_post(blog_post_id)
    blog_post(blog_post_id).body
  end

  def image_present?(blog_post_id)
    return false unless blog_post(blog_post_id)
    blog_post(blog_post_id).image.present?
  end

  def image_url(blog_post_id)
    return '' unless blog_post(blog_post_id)
    blog_post(blog_post_id).image.url(:full_size)
  end

  def free_content?(blog_post_id)
    return false unless blog_post(blog_post_id)
    blog_post(blog_post_id).free_content
  end

  def shown!(plog_post_id)
    # @blog_post ||= Admin::BlogPost.find_by(id: blog_post_id)
    # @blog_post.shown! unless @blog_post.nil?
  end

  def blog(blog_post_id)
    blog_post(blog_post_id).blog
  end

  def video_url(blog_post_id)
    return '' unless blog_post(blog_post_id)
    blog_post(blog_post_id).video_url
  end

  def has_video(blog_post_id)
    !blog_post(blog_post_id).video_url.empty?
  end

  private

  def blog_post(blog_post_id)
    @blog_post ||= Admin::BlogPost.find_by(id: blog_post_id)
    return @blog_post unless @blog_post.nil?
    Admin::BlogPost.last
  end
end
