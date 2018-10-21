class SearchController < ApplicationController
  def index
    @blog_posts =
      Admin::BlogPost
      .elasticsearch(params[:query])
      .page(params[:page])
      .per(20)
      .records


    @page             = admin_system_setup.search_page
    @landing_page     = admin_system_setup.landing_page || Page.find_by(locale: I18n.locale)
    @footer           = @page.footer
    @body_style       = @page.body_style
    session[:page_id] = @page.id

    render 'pages/show'
  # rescue
  #   render_404
  end

  def show
    @blog_post = Admin::BlogPost.find(params[:id])
    redirect_to page_post_path(@blog_post.show_on_page, @blog_post)
  end

  private

  def search_params
    params.permit!
  end
end
