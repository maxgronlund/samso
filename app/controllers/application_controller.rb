class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_admin
  before_action :set_menu
  before_action :set_default_page

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def super_admin?
    current_user && current_user.super_admin?
  end
  helper_method :super_admin?

  def admin?
    @admin ||= current_user && current_user.admin?
  end
  helper_method :admin?

  def editor?
    current_user && current_user.editor?
  end
  helper_method :editor?

  def current_url?(current_url, request_url)
    current_url == request_url
  end
  helper_method :current_url?

  def access_to_subscribed_content?
    return false unless current_user
    current_user.access_to_subscribed_content?
  end
  helper_method :access_to_subscribed_content?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_default_page
    @page ||= Admin::SystemSetup.landing_page
  end

  def set_admin
    @admin = admin?
  end

  def set_menu
    @menu = Page.for_menu('menu_bar')
  end
end
