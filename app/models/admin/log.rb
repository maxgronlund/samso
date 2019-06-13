class Admin::Log < ApplicationRecord
  ONPAY_ACCEPTED = 'OnPay accepted payment'.freeze
  ONPAY_DECLINED = 'OnPay declined payment'.freeze

  belongs_to :loggable, polymorphic: true


end
