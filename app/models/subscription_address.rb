class SubscriptionAddress < ApplicationRecord
  belongs_to(
    :admin_subscription,
    class_name: 'Admin::Subscription'
  )
  belongs_to :address
end
