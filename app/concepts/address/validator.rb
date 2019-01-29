class Address::Validator < ActiveModel::Validator
  def validate(address)
    case address.addressable_type
    when 'Admin::Subscription'
      validate_subscription_address(address)
    when 'User'
      validate_address(address)
    end
  end

  def validate_subscription_address(address)
    case address.address_type
    when Address::TEMPORARY_ADDRESS
      validate_temporary_subscription_address(address)
    when Address::PRIMARY_ADDRESS
      validate_primary_subscription_address(address)
    end
  end

  def validate_primary_subscription_address(address)
    validate_address(address)
  end

  def validate_temporary_subscription_address(address)
    validate_address(address)
    subscription = address.addressable
    if address.end_date < address.start_date + 2.weeks
      address.errors[:end_date] << 'Varigheden er ugyldig'
    end

    if address.start_date < Time.zone.today
      address.errors[:start_date] << 'Datoen kan ikke være tidligere end idag'
    end
  end

  def validate_address(address)
    address.errors[:name] << 'Navn skal udfyldes' if address.name.blank?
    address.errors[:address] << 'Adresse skal udfyldes' if address.address.blank?
    address.errors[:zipp_code] << 'Postnummer skal udfyldes' if address.zipp_code.blank?
    address.errors[:city] << 'By skal udfyldes' if address.city.blank?
  end
end