# SubscriptionType services
class Admin::SubscriptionType < ApplicationRecord
  # services for Admin::CsvImport
  class Service
    # usage: Admin::SubscriptionType::Service.translation
    def self.translation(subscription)
      case subscription.identifier
      when Admin::SubscriptionType::AB_EAN_FROM_ECONOMICS
        Admin::SubscriptionType::AB_EAN_FROM_ECONOMICS
      when Admin::SubscriptionType::FREE_FROM_ECONOMICS
        Admin::SubscriptionType::FREE_FROM_ECONOMICS
      when Admin::SubscriptionType::FROM_ECONOMICS
        Admin::SubscriptionType::FROM_ECONOMICS
      else
        ''
      end
    end
  end
end
