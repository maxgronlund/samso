# used to restrict access to the admin namespace
class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    @selected = 'dashboad'
  end
end
