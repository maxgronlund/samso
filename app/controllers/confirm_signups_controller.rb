# link from confirmation email
class ConfirmSignupsController < ApplicationController
  def show
    @user = User.find_by(reset_password_token: params[:id])
    return if @user.nil?
    user_service = User::Service.new(@user)
    if user_service.valid_token?
      user_service.reset_user
      session[:user_id] = @user.id
    else
      @user = nil
    end
  end
end
