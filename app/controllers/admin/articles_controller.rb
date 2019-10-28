# frozen_string_literal: true

class Admin::ArticlesController < AdminController
  def index
    @blog_post =
      if params[:search].present?
        blog_posts
      else
        Admin::BlogPost.order('start_date DESC').page params[:page]
      end
    @selected = 'articles'
    @blog_posts_count = Admin::BlogPost.count
  end

  private

  def blog_posts
    Admin::BlogPost
      .order(start_date: :desc)
      .search_for(params[:search])
      .page(params[:page])
      .per(20)
  end
end
