# Dynamic subscription types
class Admin::SubscriptionType < ApplicationRecord
  has_many :subscriptions, class_name: 'Admin::Subscription', foreign_key: :subscription_type_id

  scope :active, -> { where(active: true) }
  scope :locale, -> { where(locale: I18n.locale.to_s) }

  def self.for_subscription
    active.locale.order(:position)
  end
end
