# used to restrict access to the admin namespace
class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
  end
end
