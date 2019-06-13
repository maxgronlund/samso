class DeclinedPaymentsController < ApplicationController
  def index
    params.permit!
    render_404 and return if payment.nil?
    # render_404 and return if payment.created_at < Time.zone.now - 20.minutes
    log_payment
    update_payment
  end

  private

  # no matter what we log the response from onpay
  def log_payment
    info = onpay_info(params)
    Admin::Log.create(
      title: info[:onpay_reference],
      log_type: Admin::Log::ONPAY_DECLINED,
      info: info
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
