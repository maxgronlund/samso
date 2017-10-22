# usage http://localhost:3000/rails/mailers/user_notifier_mailer/send_reset_password_link
class UserNotifierMailerPreview < ActionMailer::Preview
  def send_reset_password_link
    User
      .first
      .update_attributes(
        reset_password_token: SecureRandom.hex(32),
        reset_password_sent_at: Time.zone.now
      )
    UserNotifierMailer.send_reset_password_link(User.first.id)
  end

  # usage http://localhost:3000/rails/mailers/user_notifier_mailer/send_signup_email
  def send_signup_email
    user = User.first
    user
      .update_attributes(
        confirmation_token: SecureRandom.hex(32),
        confirmation_sent_at: Time.zone.now
      )
    UserNotifierMailer.send_signup_email(user.id)
  end
end
