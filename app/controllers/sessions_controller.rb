class SessionsController < ApplicationController
  def index
    redirect_to new_session_path
  end

  def new
    set_menu
    @landing_page = admin_system_setup.landing_page
    params[:email] = session_params[:email]
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
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
end
