# used to restrict access to the admin namespace
class AdminController < ActionController::Base
  before_action :authenticate_user!

  def index

  end
end
