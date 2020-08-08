# Subscription services
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Service
    # usage: Admin::Subscription::Service.send_reminders
    def self.send_reminders
      subscription_types.each do |subscription_type|
        remind_date = Date.today + subscription_type.remind_before_days
        subscription_type
          .subscriptions
          .where('end_date = :end_date', end_date: remind_date)
          .each do |subscription|
            remind(subscription, subscription_type)
        end
      end
    end

    def self.remind_date(days)
      Date.today + days.days
    end

    # Admin::Subscription::Service.subscription_ids
    def self.subscription_types
      Admin::SubscriptionType
        .where(send_reminder: true)
    end

    def self.remind(subscription, subscription_type)
      UserNotifierMailer
        .subscription_about_to_expier(
            subscription.user_id,
            subscription_type.remind_before_days,
            subscription.subscription_id
          )
        .deliver
    end
  end
end
