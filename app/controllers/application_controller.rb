# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_admin
  before_action :set_menu
  before_action :set_default_page

  rescue_from ActionView::MissingTemplate do
    render_404
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def super_admin?
    @super_admin ||=
      current_user.present? && current_user.super_admin?
  end
  helper_method :super_admin?

  def admin?
    @admin ||=
      current_user.present? && current_user.admin?
  end
  helper_method :admin?

  def administrator?
    @administrator ||=
      current_user.present? && current_user.administrator?
  end
  helper_method :administrator?

  def editor?
    @editor ||=
      current_user.present? && current_user.editor?
  end
  helper_method :editor?

  def current_url?(current_url, request_url)
    current_url == request_url
  end
  helper_method :current_url?

  def access_to_subscribed_content?
    return false unless current_user
    return true if editor?

    current_user.access_to_subscribed_content?
  end
  helper_method :access_to_subscribed_content?

  def access_to_e_paper?
    return true
    return false unless current_user
    return true if editor?

    current_user.access_to_e_paper?
  end
  helper_method :access_to_e_paper?

  def can_manage_resource?(resource)
    return false if current_user.nil?
    return true if editor?

    current_user.can_manage_resource?(resource)
  end
  helper_method :can_manage_resource?

  def admin_system_setup
    @admin_system_setup ||= Admin::SystemSetup.find_by(locale: I18n.locale)
  end
  helper_method :admin_system_setup

  def landing_page
    @landing_page ||= admin_system_setup.landing_page
  end

  def admin_page
    edit_admin_system_setup_path(admin_system_setup.id)
  end

  def navbar_logo
    @navbar_logo ||= admin_system_setup.logo(:original)
  end
  helper_method :navbar_logo

  def navbar_style
    @navbar_style =
      "background-color: #{admin_system_setup.background_color}"
  end
  helper_method :navbar_style

  def gdpr_acceptance_missing?
    return false if current_user.nil?

    !current_user.gdpr_accepted
  end
  helper_method :gdpr_acceptance_missing?

  protected

  # rubocop:disable Naming/MemoizedInstanceVariableName
  def set_default_page
    @body_style = ''
    @page ||= landing_page
  end
  # rubocop:enable Naming/MemoizedInstanceVariableName

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
    #@current_user ||= User.find_by(id: session[:user_id])
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_admin
    return if Rails.env.test?
    return true if editor?
    return true if administrator?
    return true if super_admin?

    render_403
  end
  helper_method :authenticate_user!

  def no_editor
    render_403 if current_user.nil? || current_user.roles.where(permission: Role::EDITOR).any?
  end

  def default_path(path)
    return path if session[:stored_path].nil?

    path = session[:stored_path]
    session.delete :stored_path
    path
  end
end
# rubocop:enable Metrics/ClassLength
