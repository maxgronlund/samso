# Newsletter to users
class NewsletterMailer < ApplicationMailer
  default from: 'support@samsoposten.dk'
  layout 'newsletter_mailer'

  def send_newsletter(options = {})
    @newsletter = options[:newsletter]
    @user = options[:user]
    mail(
      to: @user.email,
      subject: 'Nyhedsbrev fra samso'
    )
  end
end
