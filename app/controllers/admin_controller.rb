# used to restrict access to the admin namespace
class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @selected = 'dashboad'
    @system_setup = admin_system_setup
    @subscription_module = Admin::SystemSetup.subscription_module
  end

  def set_namespace
    @admin_namespace = true
  end
end
