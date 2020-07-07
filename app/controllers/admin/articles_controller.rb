# frozen_string_literal: true

class Admin::ArticlesController < AdminController
  def index


    @blog_post =
      if params[:search].present?
        @blog_posts =
          Admin::BlogPost
            .search(params[:search], order: [start_date: :desc], page: params[:page], per_page: 50)
      else
        Admin::BlogPost.order('start_date DESC').page params[:page]
      end
    @selected = 'articles'
    @blog_posts_count = Admin::BlogPost.count
  end
end
