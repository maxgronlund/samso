# Subscription services
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Service
    # usage: Admin::Subscription::Service.send_reminders
    def self.send_reminders
      users_ids_to_notify.each do |user_id|
        user = User.find(user_id)
        UserNotifierMailer.subscription_about_to_expier(user.id).deliver
      end
    end

    def self.query
      'end_date >= :start AND end_date <= :end'
    end

    # usage: Admin::Subscription::Service.users_to_notify
    def self.users_ids_to_notify
      Admin::Subscription
        .without_reminders
        .valid
        .where(query, start: start_date, end: end_date)
        .pluck(:user_id)
        .uniq
    end

    def self.start_date
      Time.zone.now.beginning_of_day - 1.day
    end

    def self.end_date
      Time.zone.now.beginning_of_day + 5.days
    end

    def self.remind_date(days)
      Date.today + days.days
    end

    # Admin::Subscription::Service.subscription_ids
    def self.subscription_types
      Admin::SubscriptionType
        .where(send_reminder: true)
    end

    # Object.send(:remove_const, :Admin::Subscription::Service)
    # load :Admin::Subscription::Service
    # Admin::Subscription::Service.subscriptions_to_remind
    def self.subscriptions_to_remind
      subscription_types.each do |subscription_type|
        remind_date = remind_date(subscription_type.remind_before_days)
        subscription_type
          .subscriptions
          .where('end_date = :end_date', end_date: remind_date)
          .each do |subscription|
            remind(subscription, subscription_type)
        end
      end
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
