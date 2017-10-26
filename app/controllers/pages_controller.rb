class PagesController < ApplicationController
  # GET /pages/1
  def show
    @page =
      Page
      .includes(page_rows: [page_cols: [:page_col_modules]])
      .find(params[:id])
    @landing_page     = admin_system_setup.landing_page
    @footer           = @page.footer
    @body_style       = @page.body_style
    session[:page_id] = @page.id
  rescue
    render_404
  end
end
