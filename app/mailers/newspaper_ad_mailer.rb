# notifications to users
class NewspaperAdMailer < ApplicationMailer
  default from: 'no-reply@samso.dk'
  layout 'address_update_mailer'

  # send a signup email to the user, pass in the user object that
  # contains the user's email address
  # usage UserNotifierMailer.send_signup_email(5).deliver_now
  def send_message_to_administrators(options = {})
    emails = options[:emails]
    @link = options[:link]
    id    = options[:printed_ad_id]
    @printed_ad = ServiceFunctions::PrintedAd.find(id)

    emails.split(',').each do |email|
      next if email.delete(' ').invalid_email?

      mail(
        to: email,
        subject: 'Abonnoment adresse er flyttet'
      )
    end
  end
end
