# link from confirmation email
class ConfirmSignupsController < ApplicationController
  def show
    redirect_to current_user if current_user
    @user = User.find_by(confirmation_token: params[:id])
    return if @user.nil?
    user_service = User::Service.new(@user)
    return unless user_service.valid_confirmation_token?
    user_service.initialize_user
    session[:user_id] = @user.id
  end
end
