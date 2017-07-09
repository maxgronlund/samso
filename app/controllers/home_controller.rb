class HomeController < ApplicationController
  def index
    landing_page = Admin::SystemSetup.landing_page
    redirect_to page_path(landing_page) if landing_page
  end
end
