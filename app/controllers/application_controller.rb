class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters
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

  def can_manage_resource?(resource)
    return true if editor?
    current_user && current_user.can_manage_resource?(resource)
  end
  helper_method :can_manage_resource?

  def admin_system_setup
    @admin_system_setup ||= Admin::SystemSetup.find_by(locale: I18n.locale)
  end
  helper_method :admin_system_setup

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_default_page
    @page ||= admin_system_setup.landing_page
  end

  def set_admin
    @admin = admin?
  end

  def set_menu
    @menu = Page.for_menu('menu_bar')
  end

  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def render_403
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/403", layout: false, status: :forbidden }
      format.xml  { head :forbidden }
      format.any  { head :forbidden }
    end
  end

  def current_user
    return User.find_by(email: 'test01@example.com') if Rails.env.test?
    @currnet_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def user_signed_in?
    !current_user.nil?
  end
  helper_method :user_signed_in?

  def authenticate_admin!
    return if Rails.env.test?
    render_403 unless user_signed_in? && current_user.administrator?
  end
  helper_method :authenticate_user!
end
