class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def super_admin?
    current_user && current_user.super_admin?
  end
  helper_method :super_admin?

  def admin?
    current_user && current_user.admin?
  end
  helper_method :admin?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
