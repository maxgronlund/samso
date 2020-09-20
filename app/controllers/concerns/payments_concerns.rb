module PaymentsConcerns
  extend ActiveSupport::Concern

  def build_form_data(options = {})
    @subscription_type = options[:subscription_type]
    user = options[:user]
    payable_type = options[:payable_type]
    payable_id = options[:payable_id]
    payment = user.payments.pending.first_or_initialize
    payment.onpay_reference = SecureRandom.uuid if payment.onpay_reference == 'na'
    payment.payable_type = payable_type
    payment.payable_id = payable_id
    payment.payment_provider = Payment::PROVIDER_ONPAY
    payment.uuid = SecureRandom.uuid if payment.uuid.nil?

    payment.save!
    ap payment

    @form_data = form_data(@subscription_type, payment.secure_onpay_reference)

    @onpay_hmac_sha1 =
      Payment::Service
      .mac_sha1(@form_data, ENV['ON_PAY_SECRET'])
  end

  private

  # Use this to calculate the @onpay_hmac_sha1 for usage in the form
  def form_data(subscription_type, ref)
    {
      onpay_gatewayid: ENV['ONPAY_GATEWAY_ID'],
      onpay_currency: ENV['ONPAY_CURRENCY'],
      onpay_amount: subscription_type.form_price,
      onpay_reference: ref,
      onpay_accepturl: ENV['ONPAY_ACCEPTURL'],
      onpay_declineurl: ENV['ONPAY_DECLINEURL'],
      onpay_testmode: ENV['ONPAY_TESTMODE'],
      subscription_type_id: subscription_type.id.to_s
    }
  end
end
