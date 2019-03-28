module PaymentsConcerns
  extend ActiveSupport::Concern

  def build_form_data(options = {})
    @subscription_type = options[:subscription_type]
    user = options[:user]
    payable_type = options[:payable_type]
    payable_id = options[:payable_id]

    last_id = Payment.last.present? ? Payment.last.id : 0
    onpay_reference = 'SP-' + (last_id + 8000).to_s

    payment =
      user
      .payments
      .pending
      .first_or_initialize
    payment.onpay_reference = onpay_reference
    payment.payable_type = payable_type
    payment.payable_id = payable_id
    payment.payment_provider = Payment::PROVIDER_ONPAY
    payment.uuid = SecureRandom.uuid
    payment.save
    @form_data = form_data(@subscription_type, onpay_reference)

    @onpay_hmac_sha1 =
      Payment::Service
      .mac_sha1(@form_data, ENV['ON_PAY_SECRET'])
  end

  private

  # Use this to calculate the @onpay_hmac_sha1 for usage in the form
  def form_data(subscription_type, onpay_reference)
    {
      onpay_gatewayid: ENV['ONPAY_GATEWAY_ID'],
      onpay_currency: ENV['ONPAY_CURRENCY'],
      onpay_amount: subscription_type.form_price,
      onpay_reference: onpay_reference,
      onpay_accepturl: onpay_accepturl,
      onpay_declineurl: onpay_declineturl,
      subscription_type_id: subscription_type.id.to_s
    }
  end

  def onpay_accepturl
    Rails.env.development? ? 'https://4bd053e9.ngrok.io/da/accepted_payments' : ENV['ONPAY_ACCEPTURL']
  end

  def onpay_declineturl
    Rails.env.development? ? 'https://4bd053e9.ngrok.io/da/declined_payments' : ENV['ONPAY_DECLINEURL']
  end
end
