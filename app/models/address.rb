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
    return false if name.nil? || address.nil? || zipp_code.nil? || city.nil?
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
end
