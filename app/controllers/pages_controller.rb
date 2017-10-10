class PagesController < ApplicationController
  # GET /pages/1
  def show
    @page =
      Page
      .includes(page_rows: [page_cols: [:page_col_modules]])
      .find(params[:id])
    @landing_page    = admin_system_setup.landing_page
    @footer          = @page.footer

    store_page_in_session if @page.require_subscription
    @body_style = @page.body_style
  rescue
    render_404
  end

  private

  # store the page in a session so we can bounce to it after sign up / login
  def store_page_in_session
    return if access_to_subscribed_content?
    session[:page_id] = @page.id
    session[:post_id] = @post.id if @post
    @page = admin_system_setup.subscription_page
  end
end
