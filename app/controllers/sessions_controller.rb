class SessionsController < ApplicationController
  def index
    redirect_to new_session_path
  end

  def new
    params[:email] = session_params[:email]
  end

  # rubocop:disable Metrics/AbcSize
  def create
    user = User.find_by(email: params[:email].downcase.strip)
    if user && user.confirmed_at.nil?
      if user.confirmation_token.present?
        redirect_to confirmation_required_path(user.confirmation_token)
        return
      end
      # set_menu
      # @landing_page = admin_system_setup.landing_page
      flash.now.alert = t('please_confirm_your_account')
      render 'new'
    elsif user && user.authenticate(params[:password])
      update_login_stats(user)
      signin_user(user)
    else
      set_menu
      @landing_page = admin_system_setup.landing_page
      flash.now.alert = t('invalid_email_or_password')
      render 'new'
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    session.delete(:user_id)
    redirect_to root_url, notice: t('signed_out')
  end

  protected

  def signin_user(user)
    session[:user_id] = user.id
    redirect_to user.editor? ? admin_index_path : default_path(root_url)
  end

  def session_params
    params.permit!
  end

  def update_login_stats(user)
    User::Service.new(user).update_login_stats(request)
  end
end
