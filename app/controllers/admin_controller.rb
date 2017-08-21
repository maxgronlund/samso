# used to restrict access to the admin namespace
class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @selected = 'dashboad'
  end

  def set_namespace
    @admin_namespace = true
  end
end
