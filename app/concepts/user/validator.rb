# validate user based on address or not"
class User::Validator < ActiveModel::Validator
  def validate(record)
    ap 'validate user'
  	validate_email(record)
  end

  private

  def validate_email(record)
    return if record.imported

  	if record[:email].empty?
  		record.errors[:email] << 'Email skal udfyldes'
  	elsif record[:email].invalid_email?
  		record.errors[:email] << 'Er ikke en gyldig email'
  	end
  end

  # check if ther is another user with the same email
  def user_with_email_exists?(record)
    User
      .where(email: record[:email])
      .where.not(id: record.id)
      .any?

  end
end
