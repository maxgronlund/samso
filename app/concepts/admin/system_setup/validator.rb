# Validate system setup
class Admin::SystemSetup < ApplicationRecord
  class Validator < ActiveModel::Validator
    def validate(record)
      record.errors[:administrator_email] << 'Ugyldig email' if record.administrator_email.to_s.invalid_email?
    end
  end
end

