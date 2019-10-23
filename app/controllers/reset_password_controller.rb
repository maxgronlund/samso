class ResetPasswordController < ApplicationController
  def index
    if resend_password_params[:send] == "true"
      @message = Admin::SystemMessage.resend_password
    elsif resend_password_params[:send] == "false"
      @message = Admin::SystemMessage.no_user_found
    else

    end
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
    user = User.find_by(email: params[:email].downcase)
    if user.present?
      send_reset_password_link(user)
      redirect_to reset_password_index_path(send: true)
    else
      create_event_notification
      redirect_to reset_password_index_path(send: false, email: resend_password_params[:email])
    end
  end

  # def show
  #   @user = User.find(params[:id])
  # end

  private

  def create_event_notification
    Admin::EventNotification.create(
      title: Admin::SystemMessage.no_user_found.title,
      body: Admin::SystemMessage.no_user_found.body,
      message_type: 'reset_password',
      metadata: {
        email: resend_password_params[:email]
      }
    )
  end

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
