# find blogposts
class SearchController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def index

    @blog_posts =
      Admin::BlogPost
        .search(params[:query], order: [start_date: :desc], page: params[:page], per_page: 50)

    @page             = admin_system_setup.search_page
    @landing_page     = admin_system_setup.landing_page || Page.find_by(locale: I18n.locale)
    @footer           = @page.footer
    @body_style       = @page.body_style
    session[:page_id] = @page.id

    render 'pages/show'
  end
  # rubocop:enable Metrics/AbcSize

  def show
    @blog_post = Admin::BlogPost.find(params[:id])
    redirect_to page_post_path(@blog_post.show_page, @blog_post)
  end

  private

  def search_params
    params.permit!
  end
end

 # ap Admin::BlogPost.search_for("samso").first(10)