# module for selection subscription
class Admin::SubscriptionModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns
end
