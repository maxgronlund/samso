# link from confirmation email
class ConfirmSignupsController < ApplicationController
  def show
    @user = User.find_by(reset_password_token: params[:id])
    return if @user.nil?
    validate_token!
  end

  private

  def validate_token!
    reset_token!
    if @invalid_token
      @user = nil
    else
      session[:user_id] = @user.id
    end
  end

  def reset_token!
    @invalid_token =
      @user.reset_password_token.nil? ||
      @user.reset_password_sent_at < Time.zone.now - 2.days
    @user.reset_password_token = nil
    @user.current_sign_in_at = @invalid_token ? nil : Time.zone.now
    @user.reset_password_sent_at = nil
    @user.save
  end
end
