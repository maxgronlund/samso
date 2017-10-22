# notifications to users
class UserNotifierMailer < ApplicationMailer
  default from: 'no-reply@example.com'
  layout 'user_notifier_mailer'

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  # usage UserNotifierMailer.send_signup_email(5).deliver_now
  def send_signup_email(user_id)
    @user = User.find_by(id: user_id)
    return if @user.nil?
    @token = @user.confirmation_token
    return if @token.nil?
    @name = @user.name
    message = Admin::SystemMessage.thanks_for_signing_up_email
    @title  = message.title
    @body = message.body
    @link = confirm_signup_url(I18n.locale, @token)
    mail(
      to: @user.email,
      subject: I18n.t('thanks_for_signing_up')
    )
  end

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  def send_reset_password_link(user_id)
    @user = User.find_by(id: user_id)
    return if @user.nil?
    @token = @user.reset_password_token
    @name = @user.name
    @message = Admin::SystemMessage.new_password_email
    mail(
      to: @user.email,
      subject: @message.title
    )
  end
end
