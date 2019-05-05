# frozen_string_literal: true

# Dynamic subscription types
class Admin::SubscriptionType < ApplicationRecord
  has_many :subscriptions, class_name: 'Admin::Subscription', foreign_key: :subscription_type_id

  INTERNAL = 'internal'
  FREE = 'free'
  IMPORTED = 'imported'
  DAO_IMPORTED = 'dap-imported'
  FROM_ECONOMICS = 'Abonnement'
  FREE_FROM_ECONOMICS = 'FriAbb'
  AB_EAN_FROM_ECONOMICS = 'AB-EAN'
  FREE_SUBSCRIPTION = 'free_subscription'

  scope :active, -> { internal.where(active: true) }
  scope :locale, -> { internal.where(locale: I18n.locale.to_s) }
  scope :payed, -> { internal.where(free: false) }
  scope :internal, -> { where(identifier: INTERNAL).order(:position) }
  scope :imported, -> { where(identifier: IMPORTED) }
  scope :dao_imported, -> { find_by(identifier: DAO_IMPORTED) }
  scope :payed, -> { internal.where(free: false) }
  #scope :free, -> { find_by(identifier: FREE) }
  scope :free, -> { find_by(identifier: FREE_SUBSCRIPTION) }
  scope :from_economics, -> { find_by(identifier: FROM_ECONOMICS) }
  scope :free_from_economics, -> { find_by(identifier: FREE_FROM_ECONOMICS) }
  scope :ab_ean_economics, -> { find_by(identifier: AB_EAN_FROM_ECONOMICS) }

  def price_in_cent
    (price.presence || 0) * 100
  end

  def form_price
    price_in_cent.to_i.to_s
  end

  def free?
    return true if price.nil? || price.zero?

    free
  end

  def self.for_subscription
    internal.active.locale.payed.order(:position)
  end

  def free_from_economics?
    identifier == FREE_FROM_ECONOMICS
  end
end
