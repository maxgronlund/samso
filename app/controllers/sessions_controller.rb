class SessionsController < ApplicationController
  def index
    redirect_to new_session_path
  end

  def new
    set_menu
    @landing_page = admin_system_setup.landing_page
    params[:email] = session_params[:email]
  end

  # rubocop:disable Metrics/AbcSize
  def create
    user = User.find_by(email: params[:email])
    if user && user.confirmed_at.nil?
      set_menu
      @landing_page = admin_system_setup.landing_page
      flash.now.alert = t('please_confirm_your_account')
      render 'new'
    elsif user && user.authenticate(params[:password])
      store_stats(user)
      signin_user(user)
    else
      set_menu
      @landing_page = admin_system_setup.landing_page
      flash.now.alert = t('invalid_email_or_password')
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url, notice: t('signed_out')
  end

  protected

  def signin_user(user)
    session[:user_id] = user.id
    redirect_to root_url, notice: t('signed_in')
  end

  def session_params
    params.permit!
  end

  def store_stats(user)
    user.update_attributes(
      sign_in_count: user.sign_in_count + 1,
      last_sign_in_at: user.current_sign_in_at,
      current_sign_in_at: Time.zone.now.to_datetime,
      last_sign_in_ip: user.current_sign_in_ip,
      current_sign_in_ip: request.remote_ip
    )
  end
end
