# frozen_string_literal: true

# papertrail of payments
class Payment < ApplicationRecord
  PENDING = 'pending'.freeze
  ACCEPTED = 'accepted'.freeze
  DECLINED = 'declined'.freeze

  PROVIDER_ONPAY = 'onpay'

  #belongs_to :subscription, class_name: 'Admin::Subscription'

  belongs_to :user
  validates :user_id, presence: true

  def pending!
    update(state: PENDING)
  end

  def pending?
    state == PENDING
  end

  def accepted!
    update(state: ACCEPTED)
  end

  def accepted?
    state == ACCEPTED
  end

  def declined!
    update(state: DECLINED)
  end

  def declined?
    state == DECLINED
  end

  def payable
    return nil if payable_type.nil? || payable_id.nil?
    payable_type.constantize.find_by(id: payable_id)
  end

  def payable_name
    case payable.class.name
    when 'Admin::Subscription'
      payable.type_name
    else
      ''
    end
  end

  def for
    case payable_type
    when 'Admin::Subscription'
      payable.subscription_type.title
    else
      ''
    end
  end

  def amount
    return 0 if transaction_info.size.zero?
    case payment_provider
    when PROVIDER_ONPAY
      return transaction_info['onpay_amount'].to_i * 0.01
    else
      0
    end
  end

  def transaction_id
    case payment_provider
    when PROVIDER_ONPAY
      return transaction_info['onpay_number']
    else
      ''
    end
  end

  def payment_method
    case payment_provider
    when PROVIDER_ONPAY
      return transaction_info['onpay_cardtype']
    else
      ''
    end
  end

  def card_mask
    case payment_provider
    when PROVIDER_ONPAY
      return transaction_info['onpay_cardmask']
    else
      ''
    end
  end
end
