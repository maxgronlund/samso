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

  def subscription_id
    return id if legacy_subscription_id.empty?
    legacy_subscription_id
  end

  def expired?
    end_date < Time.zone.today
  end
end
