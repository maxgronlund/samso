class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    if session[:subscription_type_id].nil?
      # do something
    end
    @subscription_type = Admin::SubscriptionType.find(session[:subscription_type_id])
    @user = User.find(params[:user_id])
    payment =
      @user
      .payments
      .create(
        uuid: SecureRandom.uuid,
        payable_type: 'Admin::Subscription',
        payment_provider: Payment::PROVIDER_ONPAY
      )
    @form_data = form_data(@subscription_type.price_in_cent, payment.uuid)

    @onpay_hmac_sha1 =
      Payment::Service
      .mac_sha1(@form_data)
  end

  def form_data(amount, payment_uuid)
    {
      onpay_gatewayid:  ENV['ONPAY_GATEWAY_ID'],
      onpay_currency: ENV['ONPAY_CURRENCY'],
      onpay_amount: amount,
      onpay_reference: payment_uuid,
      onpay_accepturl: onpay_accepturl,
      onpay_declineurl: onpay_declineturl
    }
  end

  def destroy
    @payment.destroy
    redirect_to default_path(root_path)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  def onpay_accepturl
    Rails.env.development? ? "https://33b108c9.ngrok.io/da/acceped_payments" : ENV['ONPAY_ACCEPTURL']
  end

  def onpay_declineturl
    Rails.env.development? ? "https://33b108c9.ngrok.io/da/declined_payments" : ENV['ONPAY_DECLINEURL']
  end
end
