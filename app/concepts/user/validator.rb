# validate user based on address or not"
class User::Validator < ActiveModel::Validator
  def validate(record)
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
end
