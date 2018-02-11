# validate user based on address or not"
class User::UserValidator < ActiveModel::Validator
  def validate(record)
    # if record.first_name == "Evil"
    #   record.errors[:base] << "This person is evil"
    # end
  end
end
