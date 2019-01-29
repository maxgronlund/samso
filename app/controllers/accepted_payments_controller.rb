class AcceptedPaymentsController < ApplicationController
  def index
    params.permit!
    raise and return if payment.nil?
    # raise and return unless payment.user == current_user

    update_subscription
    update_payment
    update_subscriper
    @payment.user.destroy_pending_payments
    @message = Admin::SystemMessage.subscription_payment_completed
  end

  private

  def update_subscriper
    subscriper.update(latest_online_payment: Time.zone.now) if subscriper.present?
  end

  def subscriper
    subscription.user
  end

  def subscription
    @subscription ||= payment.payable
  end

  def payment
    @payment ||= Payment.find_by(uuid: params[:onpay_reference])
  end

  def subscription_type
    @subscription_type ||= Admin::SubscriptionType.find(params[:subscription_type_id])
  end

  def duration
    @duration ||= subscription_type.duration
  end

  def start_date
    @start_date ||= Date.today.beginning_of_day
  end

  def end_date
    start_date + duration.days
  end

  # don't update payment if it's already connected to a subscription
  def update_payment
    payment
      .update(
        transaction_info: onpay_info(params),
        state: Payment::ACCEPTED,
        payable_id: subscription.id
      )
  end

  # only create a subscription if there is none
  def update_subscription
    subscription.presence || create_subscription
  end

  def create_subscription
    @subscription = Admin::Subscription.create(subscription_options)
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
      onpay_cardmask: params[:onpay_cardmask]
    }
  end

  def subscription_options
    {
      subscription_id: Admin::Subscription.new_subscription_id,
      user_id: payment.user_id,
      subscription_type_id: subscription_type.id,
      start_date: start_date,
      end_date: end_date
    }
  end
end