# frozen_string_literal: true

# dynamic blog to add on a page
class Admin::BlogModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def paginated_posts(page_id)
    return [] if posts.nil?

    page_id = 0 if page_id.nil?
    posts
      .limit(posts_pr_page)
      .offset(page_id.to_i * posts_pr_page)
  end

  def featured_post
    return nil if blog.nil?

    @featured_post ||=
      blog
      .posts
      .where(featured: true)
      .order('start_date DESC')
      .where(
        'start_date <= :today', today: Time.zone.now
      )
  end

  def prev_page(request_path, current_page)
    page = current_page.to_i - 1
    return request_path if page <= 0

    "#{request_path}?page=#{page}"
  end

  def next_page(request_path, current_page)
    page = current_page.to_i + 1
    if show_all_categories
      return false if page * posts_pr_page >= Admin::BlogPost.count
    else
      return false if blog.nil?
      return false if page * posts_pr_page >= blog.blog_posts_count
    end
    "#{request_path}?page=#{page}"
  end

  def last_page(request_path)
    if show_all_categories
      count = Admin::BlogPost.count
    else
      return false if blog.nil?

      count = blog.blog_posts_count
    end

    page = count / posts_pr_page
    "#{request_path}?page=#{page}"
  end

  def posts
    return all_posts if show_all_categories
    return nil if blog.nil?

    @posts ||=
      blog
      .posts
      .order('start_date DESC')
      .where(
        'start_date <= :today', today: Time.zone.now
      )
  end

  def all_posts
    Admin::BlogPost.all_posts
  end

  def featured_posts
    all_posts
      .where(featured: true)
      .first(featured_posts_pr_page)
  end

  def blog
    @blog ||= Admin::Blog.find_by(id: admin_blog_id)
  end

  def self.collection
    modules = []
    Admin::BlogModule.all.each do |blog_module|
      modules << [blog_module.name, blog_module.id] unless blog_module.name.blank?
    end
    modules
  end
end
