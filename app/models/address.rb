# frozen_string_literal: true

# generic address
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, touch: true

#  include Elasticsearch::Model
#  include Elasticsearch::Model::Callbacks

  PRIMARY_ADDRESS = 'primary_address'.freeze
  TEMPORARY_ADDRESS = 'temporary_address'.freeze

  validates_with Address::Validator

  scope :primary_address, -> { find_by(address_type: PRIMARY_ADDRESS) }
  scope :temporary_address, -> { find_by(address_type: TEMPORARY_ADDRESS) }

  def valid_address?
    return false if first_name.blank? || street_name.blank? || house_number.blank? || zipp_code.blank? || city.blank?
    true
  end

  def primary?
    address_type == PRIMARY_ADDRESS
  end

  def temporary?
    address_type == TEMPORARY_ADDRESS
  end

  def temporary!
    update(address_type: TEMPORARY_ADDRESS)
  end

  def in_period?
    start_date < Time.zone.now && end_date > Time.zone.now
  end

  def user
    case addressable_type
    when 'User'
      addressable
    when 'Admin::Subscription'
      addressable.user
    end
  end

  def subscription
    return addressable if addressable.is_a?(Admin::Subscription)

    nil
  end

  def set_defaults
    self.name = 'na'
    self.address = 'na'
    self.address = 'na'
    self.zipp_code = 'na'
    self.city = 'na'
    self.first_name = 'na'
    self.middle_name = ''
    self.last_name = 'na'
    self.street_name = 'na'
    self.house_number = 0
    self.letter = ''
    self.floor = ''
    self.side = ''
    self
  end

  def default?
    return false unless self.name == 'na'
    return false unless self.address == "na"
    return false unless self.zipp_code == "na"
    return false unless self.city == "na"
    return false unless self.first_name == "na"
    return false unless self.middle_name == ""
    return false unless self.last_name == "na"
    return false unless self.street_name == "na"
    return false unless self.house_number == 0
    return false unless self.letter == ""
    return false unless self.floor == ""
    return false unless self.side == ""

    true
  end
end
