# notifications to admins
class NewspaperAdMailer < ApplicationMailer
  default from: 'support@samsoposten.dk'
  layout 'address_update_mailer'


  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  # usage UserNotifierMailer.send_signup_email(5).deliver_now
  def send_message_to_administrators(options = {})

    emails = options[:emails]
    @link = options[:link]
    id    = options[:printed_ad_id]
    @printed_ad = ServiceFunctions::PrintedAd.find(id)

    @printed_ad_url = "#{ENV['RAILS_HOST']}/#{I18n.locale}/admin/newspaper_ads/#{id}"

    emails.split(',').each do |email|
      next if email.delete(' ').invalid_email?
      ap 'sending email'
      mail(
        to: email,
        subject: 'Der er oprettet en annonce på samsoposten'
      )
    end
  end
end
