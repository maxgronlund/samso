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
    @temporary_address =
      addresses
      .find_by(address_type: Address::TEMPORARY_ADDRESS)
  end

  def delivery_address
    return Address.new if addresses.count.zero?
    return address if addresses.count == 1
    return temporary_address if temporary_address.in_period?
    primary_address
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

  HEADER = %i[Gruppe  abonr fornavn mellemnavn efternavn attention kontaktperson vejnavn husnr litra sal side postnr bynavn land antalaviser co tiltaleform gadeident david]

  def self.to_csv
    # attributes = %w{id fo}

    CSV.generate(headers: true) do |csv|
      csv << HEADER

      all.each do |subscription|
        csv << [
          subscription.group,
          subscription.subscription_id,
          subscription.first_name,
          subscription.middle_name,
          subscription.last_name,
          '',
          '',
          subscription.delivery_address.address,
          subscription.delivery_address.address.to_i,
          '',
          '',
          '',
          subscription.delivery_address.zipp_code,
          subscription.delivery_address.city,
          'DK',
          '1',
          '',
          '',
          '',
          ''
        ]
      end
    end
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
