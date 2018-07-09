class GdprController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    current_user.update(gdpr_accepted: true)
    redirect_to_path =  session[:gdpr_acceptad_path] || root_path
    session.delete :gdpr_acceptad_path
    redirect_to redirect_to_path
  end
end
