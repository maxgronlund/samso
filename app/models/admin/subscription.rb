# frozen_string_literal: true

# a subscription
class Admin::Subscription < ApplicationRecord
  attr_accessor :on_hold
  belongs_to :subscription_type, class_name: 'Admin::SubscriptionType', counter_cache: true
  belongs_to :user
  has_one :payment

  has_many(
    :addresses,
    as: :addressable,
    dependent: :destroy
  )

  def self.valid
    where('start_date <= :start_date', start_date: Date.today.beginning_of_day + 1.day)
    .where('end_date >= :end_date', end_date: Date.today.beginning_of_day)
  end

  def type_name
    return 'Imported' if subscription_type.nil?
    return 'Imported' if subscription_type.title.to_s.empty?

    subscription_type.title
  end

  def expired?
    end_date < Time.zone.today
  end

  def period_valid?
    start_date < Time.zone.today && end_date > Time.zone.today
  end

  def address
    addresses.primary_address
  end

  def print_version?
    subscription_type.print_version?
  end

  def primary_address
    return user_address_copy if addresses.primary_address.blank?
    addresses.primary_address
  end

  def temporary_address
    addresses.temporary_address
  end
  alias :set_address :primary_address

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
    new_id += 1 while subscription_exists?(new_id)
    new_id
  end

  # Admin::Subscription.subscription_exists?(id)
  def self.subscription_exists?(subscription_id)
    where(subscription_id: subscription_id.to_s).any?
  end

  def copy_from_address(address)
    primary_address
      .update(
        name: address.name,
        address: address.address,
        zipp_code: address.zipp_code,
        city: address.city
      )
  end

  private

  def user_address_copy
    user_address = user.address
    addresses
      .create(
        name: user.name,
        address: user_address.address,
        zipp_code: user_address.zipp_code,
        city: user_address.city
      )
  end
end
