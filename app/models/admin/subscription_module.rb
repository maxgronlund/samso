# frozen_string_literal: true

# module for selection subscription
class Admin::SubscriptionModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  # validates :title, presence: true
  # validates :expired_title, presence: true
end
