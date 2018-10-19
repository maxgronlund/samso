class Address < ApplicationRecord
  belongs_to :user
  validates :address, presence: true
  validates :zipp_code, presence: true
  validates :city, presence: true

  scope :user_address, -> { find_by(address_type: USER_ADDRESS) }
  scope :subscription_address, -> { where(address_type: SUBSCRIPTION_ADDRESS) }

  USER_ADDRESS = 'user_address'
  SUBSCRIPTION_ADDRESS = 'subscription_address'
end
