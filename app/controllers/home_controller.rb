class HomeController < ApplicationController
  def index
    redirect_to maintenance_index_path if Admin::SystemSetup.first.maintenance
  end
end
