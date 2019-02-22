# usage http://localhost:3000/rails/mailers/newsletter_mailer/send_newsletter
class NewsletterMailerPreview < ActionMailer::Preview
  def send_newsletter
    NewsletterMailer
      .send_newsletter(
        newsletter: Admin::Newsletter.last,
        user: User.first
      )
  end
end
