# frozen_string_literal: true

# a subscription
class Admin::Subscription < ApplicationRecord
  require 'csv'
  attr_accessor :on_hold
  belongs_to :subscription_type, class_name: 'Admin::SubscriptionType', counter_cache: true
  belongs_to :user
  #has_many :payments, as: :payable

  scope :economic_imported, -> { where(subscription_type_id: Admin::SubscriptionType.imported.id)}
  scope :free_economic_imported, -> { where(subscription_type_id: Admin::SubscriptionType.imported.id)}
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
    return 'na' if subscription_type.nil?

    subscription_type.title.presence || 'na'
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
    return false if subscription_type.nil?

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

  def delivery_address
    return Address.new if addresses.count.zero?
    return primary_address if addresses.count == 1
    return temporary_address if temporary_address.in_period?

    primary_address
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

  def editable?
    return false if subscription_type.nil?
    return false if expired?

    subscription_type.print_version
  end

  def group
    subscription_type.group
  end

  def split_name
    @split_name = user.name.split(' ')
  end

  def first_name
    split_name.first
  end

  def middle_name
    return '' if split_name.length < 2
    split_name[1...split_name.length-1].join(' ')
  end

  def last_name
    split_name.length > 1 ? split_name.last : ''
  end

  # def self.to_csv
  #   CSV.generate do |csv|
  #     csv << 'id'
  #     all.each do |subscription|
  #       csv << subscription.subscription_id
  #     end
  #   end
  # end

  HEADER = %i[ abonr fornavn mellemnavn efternavn attention kontaktperson vejnavn husnr litra sal side postnr bynavn land antalaviser co tiltaleform gadeident david]

  def self.to_csv
    # attributes = %w{id fo}

    CSV.generate(headers: true) do |csv|
      csv << HEADER

      all.each do |subscription|
        delivery_address = subscription.delivery_address
        csv << [
          subscription.subscription_id,
          delivery_address.first_name,
          delivery_address.middle_name,
          delivery_address.last_name,
          '',
          '',
          delivery_address.street_name,
          delivery_address.house_number,
          delivery_address.letter,
          delivery_address.floor,
          delivery_address.side,
          delivery_address.zipp_code,
          delivery_address.city,
          delivery_address.country,
          '1',
          '',
          '',
          '',
          ''
        ]
      end
    end
  end

  def copy_from_address(from_address)
    copy_address(from_address, primary_address)
  end

  private

  def user_address_copy
    user_address = user.address
    Address.new(
      name: user_address.name, address: user_address.address,
      zipp_code: user_address.zipp_code,
      city: user_address.city,
      country: user_address.country,
      first_name: user_address.first_name,
      middle_name: user_address.middle_name, last_name: user_address.last_name,
      street_name: user_address.street_name, house_number: user_address.house_number,
      letter: user_address.letter, floor: user_address.floor, side: user_address.side
    )
    #copy_address(user.address, address_copy)
  end
  alias copy_address user_address_copy

  def copy_address(from, to)
    to
      .update(
        name: from.name, address: from.address,
        zipp_code: from.zipp_code,
        city: from.city,
        country: from.country,
        first_name: from.first_name,
        middle_name: from.middle_name, last_name: from.last_name,
        street_name: from.street_name, house_number: from.house_number,
        letter: from.letter, floor: from.floor, side: from.side
      )
  end
end
