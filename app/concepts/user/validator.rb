# validate user based on address or not"
class User::Validator < ActiveModel::Validator
  def validate(record)
  	validate_email(record) unless record.fake_email?
  end

  private

  def validate_email(record)
  	if record[:email].empty?
  		record.errors[:email] << 'Email skal udfyldes'
  	elsif record[:email].invalid_email?
  		record.errors[:email] << 'Er ikke en gyldig email'
  	elsif record.new_record?
      check_email(record)
    else
      record.errors[:email] << 'Email er allerede brugt' if user_with_email?(record)
  	end
  end

  def check_email(record)
    record.errors[:email] << 'Email er allerede brugt' if User.exists?(email: record[:email])
  end

  # check if ther is another user with the same email
  def user_with_email?(record)
    User
      .where(email: record[:email])
      .where.not(id: record.id)
      .any?

  end
end
