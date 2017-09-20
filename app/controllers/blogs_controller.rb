class HomeController < ApplicationController
  def index
    if session[:after_sign_in_path]
      after_sign_in_path = session[:after_sign_in_path]
      session.delete :after_sign_in_path
      redirect_to after_sign_in_path
    else
      landing_page = admin_system_setup.landing_page
      redirect_to page_path(landing_page) if landing_page
    end
  end
end
