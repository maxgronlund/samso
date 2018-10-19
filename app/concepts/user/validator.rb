# validate user based on address or not"
class User::Validator < ActiveModel::Validator
  def validate(user)
    ap user.addresses.first

    # record.errors[:address] << 'Adresse skal udfyldes' if record.address.to_s.strip.empty?
    # return unless record.postal_code_and_city.to_s.strip.empty?
    # record.errors[:postal_code_and_city] << 'Postnummer / By skal udfyldes'
  end
end
