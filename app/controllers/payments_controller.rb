class PaymentsController < ApplicationController
  include PaymentsConcerns
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments/new
  def new
    if session[:subscription_type_id].nil?
      # do something
    end
    @subscription_type = Admin::SubscriptionType.find(session[:subscription_type_id])
    @user = User.find(params[:user_id])

    build_form_data(
      user: @user,
      subscription_type: @subscription_type
    )
    # payment =
    #   @user
    #   .payments
    #   .pending
    #   .first_or_initialize
    # payment.uuid = SecureRandom.uuid
    # paymentpayable_type = 'Admin::Subscription'
    # payment.payment_provider = Payment::PROVIDER_ONPAY
    # payment.save





    # @form_data = form_data(@subscription_type.price_in_cent, payment.uuid)

    # @onpay_hmac_sha1 =
    #   Payment::Service
    #   .mac_sha1(@form_data)
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


end
