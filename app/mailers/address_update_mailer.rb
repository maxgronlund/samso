# notifications to users
class AddressUpdateMailer < ApplicationMailer
  default from: 'support@samsoposten.dk'
  layout 'address_update_mailer'

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  # usage UserNotifierMailer.send_signup_email(5).deliver_now
  def send_message_to_system_administrator(options = {})
    @current_user = User.find(options[:current_user_id])
    @address = Address.find(options[:address_id])
    admin_system_setup = Admin::SystemSetup.find(options[:system_setup_id])
    @administrator_emails = admin_system_setup.administrator_email
    @subscription = Admin::Subscription.find(options[:subscription_id])
    @user = @subscription.user
    @user_url = "#{ENV['RAILS_HOST']}/admin/users/#{@user.id}"

    @administrator_emails.split(',').each do |email|
      next if email.delete(' ').invalid_email?

      mail(
        to: email,
        subject: 'Abonnoment adresse er flyttet'
      )
    end
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
