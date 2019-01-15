# frozen_string_literal: true

# Dynamic subscription types
class Admin::SubscriptionType < ApplicationRecord
  has_many :subscriptions, class_name: 'Admin::Subscription', foreign_key: :subscription_type_id

  INTERNAL = 'internal'
  IMPORTED = 'imported'
  FREE_SUBSCRIPTION = 'free_subscription'

  scope :active, -> { internal.where(active: true) }
  scope :locale, -> { internal.where(locale: I18n.locale.to_s) }
  scope :free, -> { internal.where(free: true) }
  scope :payed, -> { internal.where(free: false) }
  scope :internal, -> { where(identifier: IMPORTED) }

  def self.for_subscription
    internal.active.locale.payed.order(:position)
  end

  # Admin::SubscriptionType.imported
  def self.imported
    Admin::SubscriptionType
      .where(identifier: IMPORTED)
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
        identifier: FREE_SUBSCRIPTION,
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
