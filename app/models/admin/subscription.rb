# a subscription
class Admin::Subscription < ApplicationRecord
  belongs_to :subscription_type, class_name: 'Admin::SubscriptionType'
  belongs_to :user
  has_one :payment
end
