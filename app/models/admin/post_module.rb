# frozen_string_literal: true

# module for showning a post from the blog on a page
class Admin::PostModule < ApplicationRecord
  include PageColConcerns
  has_many :page_col_modules, as: :moduleable

  def image_present?(blog_post_id)
    return false unless blog_post(blog_post_id).present?

    blog_post(blog_post_id).image.present?
  end

  def image_url(blog_post_id)
    return '' unless blog_post(blog_post_id).present?

    blog_post_image_url(blog_post_id)
  end

  def image_caption(blog_post_id)
    blog_post(blog_post_id).present?
    blog_post(blog_post_id).image_caption
  end

  def blog_post_image_url(blog_post_id)
    @blog_post_image_url ||=
      blog_post(blog_post_id).image.url(:full_size)
  end

  def free_content?(blog_post_id)
    return false unless blog_post(blog_post_id).present?

    blog_post(blog_post_id).free_content
  end

  def blog(blog_post_id)
    @blog ||= blog_post(blog_post_id).blog
  end

  def video_url(blog_post_id)
    return '' unless blog_post(blog_post_id)

    blog_post(blog_post_id).video_url
  end

  def enable_comments(blog_post_id)
    blog_post(blog_post_id).enable_comments
  end

  def blog_post(blog_post_id)
    @blog_post ||= Admin::BlogPost.find(blog_post_id)
  rescue => e

    Admin::BlogPost.last
  end
end
