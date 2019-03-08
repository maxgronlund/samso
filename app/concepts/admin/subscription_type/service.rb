# SubscriptionType services
class Admin::SubscriptionType < ApplicationRecord
  # services for Admin::CsvImport
  class Service
    # usage: Admin::SubscriptionType::Service.default_options
    def self.default_options(options = {})
    end
  end
end
