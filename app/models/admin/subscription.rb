# frozen_string_literal: true

# a subscription
class Admin::Subscription < ApplicationRecord
  attr_accessor :on_hold
  belongs_to :subscription_type, class_name: 'Admin::SubscriptionType', counter_cache: true
  belongs_to :user
  #has_many :payments, as: :payable

  has_many(
    :addresses,
    as: :addressable,
    dependent: :destroy
  )

  validates :subscription_id, uniqueness: true

  def payments
    Payment.where(payable_type: 'Admin::Subscription', payable_id: id)
  end

  def self.valid
    where('start_date <= :start_date', start_date: Date.today.beginning_of_day + 1.day)
      .where('end_date >= :end_date', end_date: Date.today.beginning_of_day)
  end

  def type_name
    subscription_type.title
  end

  def expired?
    return false if end_date.nil?

    end_date < Time.zone.today
  end

  def period_valid?
    return true if end_date.nil? || start_date.nil?

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
  alias :set_address :primary_address

  def temporary_address
    addresses.find_by(address_type: Address::TEMPORARY_ADDRESS)
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

  def free?
    subscription_type.nil? ? true : subscription_type.free?
  end

  def self.new_subscription_id
    subscription = last
    return '900000' if subscription.nil?

    (900000 + subscription.id + 1).to_s
  end

  def imported_subscription?
    self[:subscription_id].include?('-legacy')
  end

  def economic_imported_subscription?
    self[:subscription_id].include?('-economic-import')
  end

  def subscription_id
    return self[:subscription_id].delete('-legacy') if imported_subscription?
    return self[:subscription_id].delete('-economic-import') if economic_imported_subscription?

    self[:subscription_id]
  end

  def self.legacy_subscriptions
    where('subscription_id ILIKE :subscription_id', subscription_id: '%-legacy')
      .order(:subscription_id)
  end

  def self.economic_imported_subscriptions
    where('subscription_id ILIKE :subscription_id', subscription_id: '%-economic-import')
      .order(:subscription_id)
  end

  def self.find(id)
    return nil if id.blank?

    plain(id) || legacy(id) || economic_import(id)
  end

  def self.plain(id)
    find_by(subscription_id: id)
  end

  def self.legacy(id)
    find_by(subscription_id: id + '-legacy')
  end

  def self.economic_import(id)
    find_by(subscription_id: id + '-economic-import')
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
