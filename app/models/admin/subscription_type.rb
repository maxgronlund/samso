# frozen_string_literal: true

# Dynamic subscription types
class Admin::SubscriptionType < ApplicationRecord
  has_many :subscriptions, class_name: 'Admin::Subscription', foreign_key: :subscription_type_id

  INTERNAL = 'internal'.freeze
  FREE  = 'free'.freeze
  #IMPORTED = 'imported'.freeze
  FROM_ECONOMICS = 'Abonnement'.freeze
  FREE_FROM_ECONOMICS = 'FriAbb'.freeze
  AB_EAN_FROM_ECONOMICS = 'AB-EAN'.freeze

  scope :active, -> { internal.where(active: true) }
  scope :locale, -> { internal.where(locale: I18n.locale.to_s) }
  #scope :free, -> { where(free: true) }
  scope :payed, -> { internal.where(free: false) }
  scope :imported, -> { where(identifier: IMPORTED) }
  scope :internal, -> { where(identifier: INTERNAL).order(:position) }

  scope :free, -> { find_by(identifier: FREE) }
  scope :from_economics, -> { find_by(identifier: FROM_ECONOMICS) }
  scope :free_from_economics, -> { find_by(identifier: FREE_FROM_ECONOMICS) }
  scope :ab_ean_economics, -> { find_by(identifier: AB_EAN_FROM_ECONOMICS) }

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
end
