# used to restrict access to the admin namespace
class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to root_path unless current_user.administrator?
    @selected = 'dashboad'
  end

  def set_namespace
    @admin_namespace = true
  end
end
