# validate user based on address or not"
class User::UserAddressValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:address] << 'Adresse skal udfyldes' if record.address.to_s.strip.empty?
    return unless record.postal_code_and_city.to_s.strip.empty?

    record.errors[:postal_code_and_city] << 'Postnummer / By skal udfyldes'
  end
end
