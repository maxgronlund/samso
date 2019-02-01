# validate user based on address or not"
class User::Validator < ActiveModel::Validator
  def validate(record)
  	validate_email(record) if record.validate_email
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
