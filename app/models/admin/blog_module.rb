# dynamic blog to add on a page
class Admin::BlogModule < ApplicationRecord
  has_many :posts, class_name: 'Admin::BlogPost', dependent: :destroy
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def paginated_posts(page_id)
    page_id = 0 if page_id.nil?
    latest_post
      .limit(posts_pr_page)
      .offset(page_id.to_i * posts_pr_page)
  end

  def show_on_page
    Page.find_by(id: post_page_id)
  end

  def latest_post
    posts.order('created_at DESC')
  end

  def prev_page(request_path, current_page)
    page = current_page.to_i - 1
    return request_path if page <= 0
    "#{request_path}?page=#{page}"
  end

  def next_page(request_path, current_page)
    page = current_page.to_i + 1
    return false if page * posts_pr_page >= blog_posts_count
    "#{request_path}?page=#{page}"
  end
end
