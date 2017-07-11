class Payment < ApplicationRecord
  belongs_to :subscription, class_name: 'Admin::Subscription'
  belongs_to :user
end
