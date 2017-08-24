# notifications to users
class UserNotifierMailer < ApplicationMailer
  default from: 'max@example.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user_id)
    @user = User.find_by(id: user_id)
    return if @user.nil?
    @token = @user.reset_password_token
    @name = @user.name
    # mail(
    #   to: @user.email,
    #   subject: 'Thanks for signing up for our amazing app'
    # )
    mail(
      to: @user.email,
      subject: 'Thanks for signing up for our amazing app'
    )
  end
end
