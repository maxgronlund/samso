module PaymentsConcerns
  extend ActiveSupport::Concern

  def form_data(amount, payment_uuid)
    {
      onpay_gatewayid: ENV['ONPAY_GATEWAY_ID'],
      onpay_currency: ENV['ONPAY_CURRENCY'],
      onpay_amount: amount,
      onpay_reference: payment_uuid,
      onpay_accepturl: onpay_accepturl
    }
  end

  def build_form_data(options = {})
    @subscription_type = options[:subscription_type]
    user = options[:user]

    payment =
      user
      .payments
      .pending
      .first_or_initialize
    payment.uuid = SecureRandom.uuid
    # payment.paymentpayable_type = 'Admin::Subscription'
    payment.payment_provider = Payment::PROVIDER_ONPAY
    payment.save
    @form_data = form_data(@subscription_type.price_in_cent, payment.uuid)

    @onpay_hmac_sha1 =
      Payment::Service
      .mac_sha1(@form_data)
  end

  private

  def onpay_accepturl
    Rails.env.development? ? 'https://5590f7c7.ngrok.io/da/accepted_payments' : ENV['ONPAY_ACCEPTURL']
  end

  def onpay_declineturl
    Rails.env.development? ? 'https://5590f7c7.ngrok.io/da/declined_payments' : ENV['ONPAY_DECLINEURL']
  end
end
