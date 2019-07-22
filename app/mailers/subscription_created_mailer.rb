# notifications about a printed subscription is created
class SubscriptionCreatedMailer < ApplicationMailer
  default from: 'support@samsoposten.dk'
  layout 'address_update_mailer'

  # usage SubscriptionCreatedMailer.send_message_to_system_administrator(1,1).deliver_now
  def send_message_to_system_administrator(subscription_id)
    @subscription = Admin::Subscription.find(subscription_id)
    @address = @subscription.delivery_address
    @user = @subscription.user
    @user_url = "#{ENV['RAILS_HOST']}/admin/users/#{@user.id}"

    mail(
      to: Admin::SystemSetup.order_completed_emails,
      subject: 'Abonnement oprettet'
    )
  end
end
