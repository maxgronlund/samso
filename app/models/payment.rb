# papertrail of payments
class Payment < ApplicationRecord
  belongs_to :subscription, class_name: 'Admin::Subscription'
  belongs_to :user
  validates :name, :subscription_id, :user_id, presence: true
end
