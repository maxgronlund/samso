# frozen_string_literal: true

namespace :addresses do

  # usage
  # rake addresses:update_address_fields
  desc 'Update address with first middle and last name'
  task update_address_fields: :environment do
    Address.find_each do |address|
      Address::Service.update_address(address)
    end
  end

  # usage
  # rake addresses:create_user_addresse
  desc 'Create one addresses record for all users'
  task create_for_users: :environment do
    User.find_each do |user|
      create_address(user)
    end
  end

  desc 'Delete all user addresses'
  task destroy_for_users: :environment do
    Address.where(addressable_type: 'User').destroy_all
  end

  def create_address(user)
    address           = user.addresses.first_or_initialize
    zipp_code         = parse_zipp_code(user)
    city              = parse_city(user, zipp_code)
    address.zipp_code = zipp_code if zipp_code.present?
    address.city      = city if city.present?
    address.name      = user.name
    address.address   = user.address
    address.save if address.changed?
  end

  def parse_zipp_code(user)
    zipp_code = postal_code_and_city(user).first
    zipp_code = zipp_code.to_i
    return zipp_code if zipp_code < 10000 && zipp_code > 999

    nil
  end

  def parse_city(user, zipp_code)
    city = postal_code_and_city(user)
    city.delete_at(0) if zipp_code.is_a?(Integer)
    city.join(' ')
  end

  def postal_code_and_city(user)
    return [] if user.postal_code_and_city.blank?

    user.postal_code_and_city.split
  end
end
