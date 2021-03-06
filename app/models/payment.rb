# frozen_string_literal: true

# papertrail of payments
class Payment < ApplicationRecord
  PENDING = 'pending'
  ACCEPTED = 'accepted'
  DECLINED = 'declined'
  PROVIDER_ONPAY = 'onpay'

  scope :pending, -> { where(state: PENDING) }
  scope :accepted, -> { where(state: ACCEPTED) }

  belongs_to :user
  # belongs_to :payable
  validates :user_id, presence: true
  validates :onpay_reference, uniqueness: true

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
  rescue => e
    nil
  end

  def payable_name
    case payable.class.name
    when 'Admin::Subscription'
      payable.type_name
    else
      'Ukendt'
    end
  end

  def for
    return 'Afvist' if state == DECLINED
    return 'Afventer' if state == PENDING
    return payment_name if payable.nil?

    case payable_type
    when 'Admin::Subscription'
      payable.subscription_type&.title
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
      transaction_info['onpay_reference']
    else
      ''
    end
  end

  def payment_method
    case payment_provider
    when PROVIDER_ONPAY
      transaction_info['onpay_cardtype'].presence || 'Onpay'
    else
      ''
    end
  end

  def card_mask
    case payment_provider
    when PROVIDER_ONPAY
      transaction_info['onpay_cardmask']
    else
      ''
    end
  end

  def payment_name
    'Abonnoment'
  end

  def secure_onpay_reference
    return onpay_reference if onpay_reference.include?('SP-')
    formatted_id = (id + 8001).to_s
    ref = Rails.env.development? ? 'SP-DEV-' + formatted_id : 'SP-' + formatted_id
    update(onpay_reference: ref)
    onpay_reference
  end
end
