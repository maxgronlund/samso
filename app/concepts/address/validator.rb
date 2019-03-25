class Address::Validator < ActiveModel::Validator
  def validate(address)
    case address.addressable_type
    when 'Admin::Subscription'
      validate_subscription_address(address)
    when 'User'
      validate_address(address) # if address_present?(address)
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

  def address_present?(address)
    address.address.present? || address.zipp_code.present? || address.city.present?
  end

  def validate_primary_subscription_address(address)
    validate_address(address)
  end

  def validate_temporary_subscription_address(address)
    validate_address(address)
    subscription = address.addressable
    if address.end_date < address.start_date + 1.week
      address.errors[:end_date] << 'Varigheden er ugyldig'
    end

    if address.start_date < Time.zone.today - 1.day
      address.errors[:start_date] << 'Datoen kan ikke være tidligere end idag'
    end
  end

  def validate_address(address)
    address.errors[:first_name] << 'Fornavn skal udfyldes' if address.first_name.blank?
    address.errors[:last_name] << 'Efternavn skal udfyldes' if address.last_name.blank?
    address.errors[:street_name] << 'Gadenavn skal udfyldes' if address.street_name.blank?
    address.errors[:house_number] << 'Husnummer skal udfyldes' if address.house_number.blank?
    address.errors[:zipp_code] << 'Postnummer skal udfyldes' if address.zipp_code.blank?
    address.errors[:city] << 'By skal udfyldes' if address.city.blank?
  end
end