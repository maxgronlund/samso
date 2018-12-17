# frozen_string_literal: true

class Admin::ArticlesController < AdminController
  def index
    @blog_pots =
      if params[:search] && !params[:search].empty?
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
      .search(params[:search])
      .records
      .order(start_date: :desc)
      .page(params[:page])
      .per(20)
  end
end
