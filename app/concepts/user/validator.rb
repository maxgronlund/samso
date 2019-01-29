# validate user based on address or not"
class User::Validator < ActiveModel::Validator
  def validate(record)
  	
  	validate_email(record) if record.validate_email
  	
    # record.addresses.first.errors[:address] << 'Adresse skal udfyldes' if record.addresses.first.address.empty?
    #return unless record.postal_code_and_city.to_s.strip.empty?

    #record.errors[:postal_code_and_city] << 'Postnummer / By skal udfyldes'
  end

  private

  def validate_email(record)
  	if record[:email].empty?
  		record.errors[:email] << 'Email skal udfyldes'
  	elsif record[:email].invalid_email?
  		record.errors[:email] << 'Er ikke en gyldig email'
  	elsif User.find_by(email: record[:email]).present?
  		record.errors[:email] << 'Email er allerede brugt'
  	end
  		
  	
  end
end
