# frozen_string_literal: true

# Dynamic subscription types
class Admin::SubscriptionType < ApplicationRecord
  has_many :subscriptions, class_name: 'Admin::Subscription', foreign_key: :subscription_type_id

  INTERNAL = 'internal'
  IMPORTED = 'imported'
  IMPORTED_FROM_ECONOMICS = 'imported_from_economics'
  FREE_SUBSCRIPTION = 'free_subscription'

  scope :active, -> { internal.where(active: true) }
  scope :locale, -> { internal.where(locale: I18n.locale.to_s) }
  scope :free, -> { where(free: true) }
  scope :payed, -> { internal.where(free: false) }
  scope :imported, -> { where(identifier: IMPORTED) }
  scope :internal, -> { where(identifier: INTERNAL).order(:position) }

  def price_in_cent
    (price.presence || 0) * 100
  end

  def free?
    return true if price.nil? || price.zero?

    free
  end

  def self.for_subscription
    internal.active.locale.payed.order(:position)
  end

  # Admin::SubscriptionType.imported
  def self.imported
    where(imported_options).first_or_create
  end

  def self.imported_options
    {
      identifier: IMPORTED_FROM_ECONOMICS,
      duration: 365000,
      internet_version: true,
      print_version: true,
      price: 500,
      locale: 'da',
      active: false,
      position: 0,
      free: false,
      title: 'E-Conomics',
      body: 'Import fra economics, kan ikke slettes og bliver oprettet automatisk'
    }
  end

  # Admin::SubscriptionType.free_subscription
  def self.free_subscription
    where(identifier: FREE_SUBSCRIPTION)
      .first_or_create(
        title: 'Fri abonnement ',
        body: 'Fri adgang til online version, kan ikke slettes og bliver oprettet automatisk',
        identifier: FREE_SUBSCRIPTION,
        duration: 365000,
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: false,
        position: 0,
        free: true
      )
  end
end
