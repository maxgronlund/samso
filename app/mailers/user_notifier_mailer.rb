# notifications to users
class UserNotifierMailer < ApplicationMailer
  default from: 'support@samsoposten.dk'
  layout 'user_notifier_mailer'

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  # usage UserNotifierMailer.send_signup_email(5).deliver_now
  def send_signup_email(user_id)
    @user = User.find(user_id)

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
  rescue => e
    return
  end

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  def send_reset_password_link(user_id)
    @user = User.find(user_id)
    return if @user.nil?

    @token = @user.reset_password_token
    @name = @user.name
    @message = Admin::SystemMessage.new_password_email
    mail(
      to: @user.email,
      subject: @message.title
    )
  end

  # send a welcome message to the user, pass in the user object that
  # contains the user's email address
  def welcome_message(user_id)
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

  def subscription_about_to_expier(user_id, days, subscription_id)
    @user = User.find(user_id)
    if Rails.env == 'development'
      return unless @user.email == 'admin@synthmax.dk'
    end
    expires_in_days = in_days(days)

    @message = Admin::SystemMessage.subscription_about_to_expire
    @title = @message.title.gsub("EXPIRES_IN_DAYS", expires_in_days)
    @subscription_id = subscription_id
    @body =
      @message.body
      .gsub("USERNAME", @user.name)
      .gsub("EXPIRES_IN_DAYS", expires_in_days)
    mail(
      to: @user.email,
      subject: @title
    )
  end

  def  in_days(days)
    I18n.t("subscription_type.remind_before_days", count: days)
  end

  def link(subscription_id)
    here = I18n.t("subscription_type.here")
    link_to here, edit_renew_subscriptions_url
  end
end
