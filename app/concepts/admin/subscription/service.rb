# subscriptions imported from e-conomics

# rubocop:disable Metrics/ClassLength
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

    def self.start_date
      Time.zone.now.beginning_of_day
    end

    def self.end_date
      Time.zone.now.beginning_of_day + 5.days
    end

    def e_comonic_integration
      
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
  end
end
# rubocop:enable Metrics/ClassLength


#end_date = Time.zone.now.beginning_of_day + 1.days


#(end_date <= Time.zone.now.beginning_of_day) && (end_date >= Time.zone.now.beginning_of_day - 5.days)
