# Dynamic subscription types
class Admin::SubscriptionType < ApplicationRecord
  has_many :subscriptions, class_name: 'Admin::Subscription', foreign_key: :subscription_type_id

  scope :active, -> { internal.where(active: true, free: false) }
  scope :locale, -> { internal.where(locale: I18n.locale.to_s) }
  scope :free, -> { internal.where(active: true, free: true) }
  scope :internal, -> {where(identifier: 'internal')}

  def self.for_subscription
    active.locale.order(:position)
  end

  # Admin::SubscriptionType.imported
  def self.imported
    Admin::SubscriptionType
      .where(identifier: 'imported')
      .first_or_create(
        title: 'Imported from E-Conomics',
        body: 'Auto generated',
        identifier: 'imported',
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: true,
        position: 0,
        free: false
      )
  end

  # Admin::SubscriptionType.imported
  def self.free_subscription
    Admin::SubscriptionType
      .where(identifier: 'free_subscription')
      .first_or_create(
        title: 'Fri abonnement ',
        body: 'Fri adgang til online version',
        identifier: 'free_subscription',
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: true,
        position: 0,
        free: true
      )
  end
end
