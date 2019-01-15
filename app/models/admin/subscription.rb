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
    subscription_type.title
  end

  def expired?
    end_date < Time.zone.today
  end

  def period_valid?
    start_date < Time.zone.today && end_date > Time.zone.today
  end

  def address
    addresses.find_by(address_type: Address::PRIMARY_ADDRESS)
  end

  def print_version?
    subscription_type.print_version?
  end

  def primary_address
    return user_address_copy if addresses.primary_address.blank?
    addresses.primary_address
  end

  def temporary_address
    addresses.find_by(address_type: Address::TEMPORARY_ADDRESS)
  end
  alias :set_address :primary_address

  def copy_from_address(address)
    primary_address
      .update(
        name: address.name,
        address: address.address,
        zipp_code: address.zipp_code,
        city: address.city
      )
  end

  def self.new_subscription_id
    subscription = last
    return '900000' if subscription.nil?

    (900000 + count + 1).to_s
  end

  def imported_subscription?
    self[:subscription_id].include?('-legacy')
  end

  def subscription_id
    return self[:subscription_id].delete('-legacy') if imported_subscription?

    self[:subscription_id]
  end

  def self.legacy_subscriptions
    where('subscription_id ILIKE :subscription_id', subscription_id: '%-legacy')
    .order(:subscription_id)
  end

  def self.find(id)
    return nil if id.blank?
    find_by(subscription_id: id).presence || find_by(subscription_id: id + '-legacy')
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
