# Newsletter to users
class NewsletterMailer < ApplicationMailer
  default from: 'no-reply@samso.dk'
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
