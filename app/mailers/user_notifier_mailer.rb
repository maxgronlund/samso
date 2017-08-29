# notifications to users
class UserNotifierMailer < ApplicationMailer
  default from: 'max@example.com'

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  def send_signup_email(user_id)
    @user = User.find_by(id: user_id)
    return if @user.nil?
    @token = @user.reset_password_token
    @name = @user.name
    mail(
      to: @user.email,
      subject: 'Thanks for signing up for our amazing app'
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
