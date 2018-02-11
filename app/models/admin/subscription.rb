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

  # def subscription_id
  #   return id if legacy_subscription_id.empty?
  #   legacy_subscription_id
  # end

  def expired?
    end_date < Time.zone.today
  end

  # Admin::Subscription.next_subscription_id
  def self.next_subscription_id
    subscription =
      Admin::Subscription
      .order(:subscription_id)
      .where.not(subscription_id: nil)
      .last

    last_id = subscription.nil? ? 0 : subscription.id
    find_next_subscription_id(last_id)
  end

  def self.find_next_subscription_id(subscription_id)
    if Admin::Subscription.where(subscription_id: subscription_id).any?
      next_subscription_id?(subscription_id + 1)
    end
    subscription_id
  end
end
