# notifications to users
class SubscriptionCreatedMailer < ApplicationMailer
  default from: 'support@samsoposten.dk'
  layout 'address_update_mailer'

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  # usage SubscriptionCreatedMailer.send_message_to_system_administrator(1,1).deliver_now
  def send_message_to_system_administrator(subscription_id, system_setup_id)

    @subscription = Admin::Subscription.find(subscription_id)
    @address      = @subscription.delivery_address
    admin_system_setup = Admin::SystemSetup.find(system_setup_id)
    @administrator_emails = admin_system_setup.administrator_email
    @user         = @subscription.user
    @user_url = "#{ENV['RAILS_HOST']}/admin/users/#{@user.id}"

    @administrator_emails.split(',').each do |email|
      next if email.delete(' ').invalid_email?
      mail(
        to: email,
        subject: 'Abonnoment oprettet'
      )
    end
  end
end
