# a subscription
class Admin::Subscription < ApplicationRecord
  attr_accessor :on_hold
  belongs_to :subscription_type, class_name: 'Admin::SubscriptionType', counter_cache: true
  belongs_to :user
  has_one :payment

  def type_name
    return 'Imported' if subscription_type.nil?
    return 'Imported' if subscription_type.title.to_s.empty?
    subscription_type.title
  end

  def expired?
    end_date < Time.zone.today
  end

  # Admin::Subscription.last_subscription
  def self.last_subscription
    order(:subscription_id)
      .where
      .not(subscription_id: nil)
      .last
  end

  # Admin::Subscription.last_subscription_id
  def self.last_subscription_id
    last_subscription.nil? ? 10000000 : last_subscription.subscription_id
  end

  # Admin::Subscription.new_safe_subscription_id
  def self.new_safe_subscription_id
    new_id = last_subscription_id + 1
    while(subscription_exists?(new_id))
      new_id += 1
    end
    new_id
  end

  # Admin::Subscription.subscription_exists?(id)
  def self.subscription_exists?(subscription_id)
    where(subscription_id: subscription_id.to_s).any?
  end
end
