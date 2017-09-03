class SessionsController < ApplicationController

  def index
    redirect_to new_session_path
  end
  def new
    params[:email] = session_params[:email]
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: t('signed_in')
    else
      flash.now.alert = t('invalid_email_or_password')
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url, notice: t('signed_out')
  end

  protected

  def session_params
    params.permit!
  end
end
