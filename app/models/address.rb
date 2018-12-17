# frozen_string_literal: true

# generic address
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  PRIMARY_ADDRESS = 'primary_address'.freeze
  TEMPORARY_ADDRESS = 'temporary_address'.freeze

  scope :primary_address, -> { find_by(address_type: PRIMARY_ADDRESS) }
  scope :temporary_address, -> { find_by(address_type: TEMPORARY_ADDRESS) }

  def valid_address?
    return false if name.nil?
    return false if address.nil?
    return false if zipp_code.nil?
    return false if city.nil?

    true
  end

  def temporary?
    address_type == TEMPORARY_ADDRESS
  end

  def temporary!
    update(address_type: TEMPORARY_ADDRESS)
  end

  def user
    case addressable
    when 'User'
      addressable
    when 'Admin::Subscription'
      addressable.user
    end
    nil
  end
end
