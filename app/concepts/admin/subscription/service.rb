# subscriptions imported from e-conomics

# rubocop:disable Metrics/ClassLength
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Service
    # usage: Admin::Subscription::Service.send_reminders
    def self.send_reminders
      Admin::Subscription.valid#.where('end_date >= :start AND end_date <= :end', start: condition.first, end: condition.last)
    end

    def self.query
      'end_date >= :start AND end_date <= :end'
    end

    def self.condition
      [
        Time.zone.now.beginning_of_day,
        Time.zone.now.beginning_of_day + 5.days
      ]
    end
  end
end
# rubocop:enable Metrics/ClassLength


#end_date = Time.zone.now.beginning_of_day + 1.days


#(end_date <= Time.zone.now.beginning_of_day) && (end_date >= Time.zone.now.beginning_of_day - 5.days)
