class AcceptedPaymentsController < ApplicationController
  # The payment went true so we don't need to validate the user
  # hence the cc is a great validation
  def index
    params.permit!
    log_request
    raise and return if payment.nil?

    if payment.accepted?
      render_404
    else
      update_subscription
      secure_subscription_address
      update_payment
      initialize_user
      send_email_to_admin
      @payment.user.destroy_pending_payments
      session[:user_id] = subscriper.id
      cookies[:auth_token] = subscriper.auth_token
      @current_user = subscriper
      session[:stored_path] = root_path
      @message = Admin::SystemMessage.subscription_payment_completed
      log_payment
    end
  end

  private

  # no matter what we log the response from onpay
  def log_payment
    info = onpay_info(params)
    Admin::Log.create(
      title: info[:onpay_reference],
      log_type: Admin::Log::ONPAY_ACCEPTED,
      info: info,
      loggable_id: @payment.id,
      loggable_type: @payment.class.name
    )
  end

  def log_request
    Admin::EventNotification.create(
      title: "Accepted Payment params",
      body: "Responce from OnPay",
      message_type: 'success responce',
      metadata: params.to_h
    )
  end

  def secure_subscription_address
    return unless subscription.print_version?

    address = subscription.primary_address
    return if address.persisted?

    address.save
  end

  def send_email_to_admin
    return unless subscription.print_version?

    SubscriptionCreatedMailer
      .send_message_to_system_administrator(
        subscription.subscription_id
      ).deliver
  end

  def initialize_user
    user_service = User::Service.new(subscriper)
    user_service.initialize_user
  end

  def subscriper
    subscription.user
  end

  #### Bug here payment.payable return nil
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

  def update_subscripers_latest_online_payment
    subscriper.update(latest_online_payment: Time.zone.now) if subscriper.present?
  end

  # only extend subscription one time pr payment
  def extend_subscription
    # return if payment_completed?

    new_end_date =
      if subscription.expired?
        Time.zone.today + subscription_type.duration.days
      else
        subscription.end_date + subscription_type.duration.days
      end

    subscription
      .update(
        end_date: new_end_date,
        last_payment_uuid: payment.uuid
      )
    update_subscripers_latest_online_payment
  end

  def create_subscription
    @subscription = Admin::Subscription.create(subscription_options)
    update_subscripers_latest_online_payment
  end

  # awoid extending subscriptions by reloading the page
  # def payment_completed?
  #   payment.accepted?
  #   #@payment_completed ||= subscription.last_payment_uuid == payment.uuid
  # end

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

  # test url
  # localhost:3000/accepted_payments?onpay_reference=SP-9394&subscription_type_id=90

  def subscription_options
    {
      subscription_id: Admin::Subscription.new_subscription_id,
      user_id: payment.user_id,
      subscription_type_id: subscription_type.id,
      start_date: start_date,
      end_date: end_date,
      last_payment_uuid: payment.uuid
    }
  end
end
