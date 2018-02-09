class User::UserValidator < ActiveModel::Validator
  def validate(record)
    # ap record
    # if record.first_name == "Evil"
    #   record.errors[:base] << "This person is evil"
    # end
  end
end

# class Person < ApplicationRecord
#   validates_with GoodnessValidator
# end