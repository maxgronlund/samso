class SessionsController < ApplicationController
  def new
    ap session_params
    params[:email] = session_params[:email]
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid.'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url, notice: 'Signed out!'
  end

  protected

  def session_params
    params.permit!
  end
end
