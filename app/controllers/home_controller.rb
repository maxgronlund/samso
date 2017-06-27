class HomeController < ApplicationController
  def index
    if Admin::SystemSetup.first.maintenance
      redirect_to maintenance_index_path
    end
  end
end
