class SearchController < ApplicationController
  def index
    @blog_posts =
      Admin::BlogPost
      .elasticsearch(params[:query])
      .page(params[:page])
      .per(20)
      .records


      # .records
      # .order(start_date: :desc)
      # .page(params[:page])
      # .per(20)
  end

  def show
    @blog_post = Admin::BlogPost.find(params[:id])
    redirect_to page_post_path(@blog_post.show_on_page, @blog_post)
  end
end
