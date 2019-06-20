class DeclinedPaymentsController < ApplicationController
  include PaymentsConcerns

  def index
    params.permit!
    log_request
    render_404 and return if payment.nil?
    # render_404 and return if payment.created_at < Time.zone.now - 20.minutes
    log_payment
    update_payment
    @link_to = session[:payments_path]
    session[:payments_path] = nil
  end

  private

  def new_payment_params
    subscription_type_id = params[:subscription_type_id]
    @subscription_type = Admin::SubscriptionType.find_by(id: subscription_type_id)
    return if @subscription_type.nil?
  end

  def log_request
    Admin::EventNotification.create(
      title: "Declined Payment params",
      body: "Responce from OnPay",
      message_type: 'declined responce',
      metadata: params.to_h
    )
  end

  # no matter what we log the response from onpay
  def log_payment
    info = onpay_info(params)
    Admin::Log.create(
      title: info[:onpay_reference],
      log_type: Admin::Log::ONPAY_DECLINED,
      info: info,
      loggable_id: payment.id,
      loggable_type: payment.class.name
    )
  end

  def update_payment
    return unless payment.pending?

    payment.update(
      transaction_info: onpay_info(params),
      state: Payment::DECLINED
    )
  end

  def onpay_info(params)
    {
      onpay_uuid: params[:onpay_uuid],
      onpay_number: params[:onpay_number],
      onpay_reference: params[:onpay_reference],
      onpay_amount: params[:onpay_amount],
      onpay_currency: params[:onpay_currency],
      onpay_method: params[:onpay_method],
      onpay_cardtype: params[:onpay_cardtype],
      onpay_cardcountry: params[:onpay_cardcountry],
      onpay_acquirercode: params[:onpay_acquirercode],
      onpay_cardmask: params[:onpay_cardmask],
      onpay_status: Payment::DECLINED
    }
  end

  def payment
    @payment ||= Payment.find_by(onpay_reference: params[:onpay_reference])
  end
end
