# frozen_string_literal: true

# a subscription
class Admin::Subscription < ApplicationRecord
  attr_accessor :on_hold
  belongs_to :subscription_type, class_name: 'Admin::SubscriptionType', counter_cache: true
  belongs_to :user
  #has_many :payments, as: :payable

  scope :economic_integrated, -> { where(subscription_type_id: Admin::SubscriptionType.imported.id)}
  scope :with_reminders, -> { where(send_reminder: true)}
  scope :without_reminders, -> { where(send_reminder: [nil, false])}
  has_many(
    :addresses,
    as: :addressable,
    dependent: :destroy
  )

  validates :subscription_id, uniqueness: true

  def payments
    Payment.where(payable_type: 'Admin::Subscription', payable_id: id)
  end

  def expire!
    update(end_date: Time.zone.today.beginning_of_day - 1.day)
  end

  def self.valid
    where('start_date <= :start_date', start_date: Time.zone.today + 1.day)
      .where('end_date >= :end_date', end_date: Time.zone.today)
  end

  def type_name
    subscription_type&.title.presence || 'na'
  end

  def expired?
    end_date < Time.zone.today
    # return false if end_date.nil?

    # end_date < Time.zone.today
  end

  def valid_period?
    end_date > Time.zone.today && start_date < Time.zone.today
    # return true if end_date.nil? || start_date.nil?

    # start_date < Time.zone.today && end_date > Time.zone.today
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
  alias set_address primary_address

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

  def send_reminder!
    return if reminder_send
    update(reminder_send: true)
  end

  def self.new_subscription_id
    subscription = last
    return 900000 if subscription.nil?

    (900000 + subscription.id + 1)
  end

  def self.find(id)
    find_by(subscription_id: id)
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
  alias copy_address user_address_copy
end
