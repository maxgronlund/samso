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

  # Admin::Subscription.next_subscription_id
  def self.next_subscription_id
    subscription = last_subscription
    return new_safe_subscription_id if subscription.nil?
    find_next_subscription_id(subscription.subscription_id.to_i)
  end

  # Admin::Subscription.next_subscription_id
  def self.last_subscription
    Admin::Subscription
      .order(:subscription_id)
      .where.not(subscription_id: nil)
      .last
  end

  # rubocop:disable Style/IfUnlessModifier
  def self.find_next_subscription_id(subscription_id)
    if subscription_exists?(subscription_id + 1)
      next_subscription_id(subscription_id + 1)
    end
    subscription_id.to_s
  end
  # rubocop:enable Style/IfUnlessModifier

  # Admin::Subscription.new_safe_subscription_id
  def self.new_safe_subscription_id
    find_next_subscription_id(Admin::Subscription.count + 10000000)
  end

  # Admin::Subscription.subscription_exists?(id)
  def self.subscription_exists?(subscription_id)
    return false if subscription_id.nil?
    where(subscription_id: subscription_id.to_s).any?
  end
end
