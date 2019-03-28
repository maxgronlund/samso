class AcceptedPaymentsController < ApplicationController
  # The paument went true so we don't need to validate the user
  # hence te cc is a great validation
  def index
    params.permit!
    raise and return if payment.nil?
    update_subscription
    update_payment
    update_subscriper
    initialize_user
    @payment.user.destroy_pending_payments
    @message = Admin::SystemMessage.subscription_payment_completed
    session[:user_id] = subscriper.id
    @current_user = subscriper
    session[:stored_path] = root_path
  end

  private

  def initialize_user
    user_service = User::Service.new(subscriper)
    user_service.initialize_user
  end

  def update_subscriper
    subscriper.update(latest_online_payment: Time.zone.now) if subscriper.present?
  end

  # def confirm_user
  #   subscriper.update(confirmed_at: Time.zone.now)
  # end

  # def login_user
  #   session[:user_id] = subscriper.id
  # end

  def subscriper
    subscription.user
  end

  def subscription
    @subscription ||= payment.payable
  end

  def payment
    @payment ||= Payment.find_by(onpay_reference: params[:onpay_reference])
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
    subscription.present? ? extend_subscription : create_subscription
  end

  def create_subscription
    @subscription = Admin::Subscription.create(subscription_options)
  end

  # extend subscription
  def extend_subscription
    new_end_date = subscription.end_date + subscription_type.duration.days
    subscription.update(end_date: new_end_date)
  end

  # paper trail
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
      onpay_cardmask: params[:onpay_cardmask],
      onpay_status: Payment::ACCEPTED
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
