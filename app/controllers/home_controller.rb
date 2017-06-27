class HomeController < ApplicationController
  def index
    if Admin::SystemSetups.first.maintenance
      redirect_to maintenance_index_path
    end
  end
end
