# namespace to confine service class to Admin::Newsletter::Service
class Admin::Newsletter < ApplicationRecord
  # services for users
  class Service
    # Usage
    # Admin::Newsletter::Service.send_newsletters
    def self.send_newsletters
      newsletters = Admin::Newsletter.where(state: Admin::Newsletter::IN_SENDING_QUEUE)
      newsletters.each do |newsletter|
        newsletter.send!
        send_to_users(newsletter)
      end
    end

    def self.send_to_users(newsletter)
      users = User.where(subscribe_to_news: true)
      users.each do |user|
        send_to_user(user, newsletter)
      end
    end

    def self.send_to_user(user, newsletter)
      return if user.email.blank?
      return if user.email.invalid_email?

      NewsletterMailer
        .send_newsletter(
          user: user,
          newsletter: newsletter
        ).deliver
    end
  end
end
