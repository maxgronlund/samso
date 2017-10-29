class Admin::ArticlesController < AdminController
  # rubocop:disable Metrics/AbcSize
  def index
    @blog_pots =
      if params[:search] && !params[:search].empty?
        Admin::BlogPost.search_by_content(params[:search]).order('start_date DESC').page params[:page]
      else
        Admin::BlogPost.order('start_date DESC').page params[:page]
      end
    @selected = 'articles'
    @blog_pots_count = Admin::BlogPost.count
  end
end
