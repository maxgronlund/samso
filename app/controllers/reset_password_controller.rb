class ResetPasswordController < ApplicationController
  def index
    return if resend_password_params[:send].nil?

    @message = Admin::SystemMessage.resend_password
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])
    @message = I18n.t('user.password.invalid_link')
  end

  def update
    token = user_params[:reset_password_token]
    @user = User.find_by(reset_password_token: token)
    user_service = User::Service.new(@user)
    if user_service.valid_token? && user_service.reset_user(user_params)
      session[:user_id] = @user.id
      cookies[:auth_token] = @user.auth_token
      redirect_to @user, notice: t('user.password.updated')
    else
      @user = nil
      redirect_to edit_reset_password_path(token)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    send_reset_password_link(user) unless user.nil?
    redirect_to reset_password_index_path(send: true)
  end

  # def show
  #   @user = User.find(params[:id])
  # end

  private

  def resend_password_params
    params.permit!
  end

  def user_params
    resend_password_params[:user]
  end

  def send_reset_password_link(user)
    user.reset_password_token = SecureRandom.hex(32)
    user.reset_password_sent_at = Time.zone.now
    return unless user.save

    UserNotifierMailer.send_reset_password_link(user.id).deliver
  end
end
