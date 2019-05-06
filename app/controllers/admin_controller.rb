# used to restrict access to the admin namespace
class AdminController < ApplicationController
  before_action :authenticate_admin
  def index
    if administrator?
      @selected = 'dashboard'
      @system_setup = admin_system_setup
      @subscription_module = Admin::SystemSetup.subscription_module
    else
      redirect_to admin_articles_path
    end
  end

  def set_namespace
    @admin_namespace = true
  end
end
