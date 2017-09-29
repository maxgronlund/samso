# a subscription
class Admin::Subscription < ApplicationRecord
  attr_accessor :on_hold
  belongs_to :subscription_type, class_name: 'Admin::SubscriptionType', counter_cache: true
  belongs_to :user
  has_one :payment
end
