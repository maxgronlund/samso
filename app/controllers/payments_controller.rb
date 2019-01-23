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
    ap ENV['ONPAY_GATEWAY_ID']
    @landing_page      = admin_system_setup.landing_page
    @subscription_type = Admin::SubscriptionType.find(session[:subscription_type_id])
    @user              = User.find(params[:user_id])

    subscription_id = Admin::Subscription.new_subscription_id

    @subscription =
      @user
      .subscriptions
      .pending
      .first_or_initialize

    @subscription.subscription_id = subscription_id
    @subscription.start_date = Date.today
    @subscription.end_date = Date.today + @subscription_type.duration.to_i.days
    @subscription.subscription_type_id = @subscription_type.id
    @subscription.save!

    @form_data = form_data(@subscription_type.price_in_cent, subscription_id)

    @onpay_hmac_sha1 =
      Payment::Service
      .mac_sha1(@form_data)
  end

  def form_data(amount, subscription_id)
    {
      onpay_gatewayid:  ENV['ONPAY_GATEWAY_ID'],
      onpay_currency: ENV['ONPAY_CURRENCY'],
      onpay_amount: amount,
      onpay_reference: subscription_id,
      onpay_accepturl: ENV['ONPAY_ACCEPTURL'],
      onpay_declineurl: ENV['ONPAY_DECLINEURL']
    }
  end

  # def form_data
  #   {
  #     onpay_gatewayid: '2007010985569',
  #     onpay_currency: 'DKK',
  #     onpay_amount: '100',
  #     onpay_reference: 'AF-847824',
  #     onpay_accepturl: 'https://1a86f4f7.ngrok.io'
  #   }
  # end

  # GET /payments/1/edit
  def edit
  end

  # rubocop:disable Style/IfUnlessModifier
  def create
    ap 'CREATE'
    @user = User.find(params[:user_id])
    # ActiveRecord::Base.transaction do
    #   create_subscription
    #   create_payment
    #   if @subscription.nil? || @payment.nil?
    #     raise ActiveRecord::Rollback, 'something went wrong'
    #   end
    # end
    go_to_page
  end
  # rubocop:enable Style/IfUnlessModifier

  def go_to_page
    url = session[:redirect_to]
    if url.nil?
      redirect_to root_path
    else
      session.delete :redirect_to
      redirect_to url
    end
  end

  def create_subscription
    ap 'create_subscription'
    # subscription_type =
    #   Admin::SubscriptionType.find(session[:subscription_type_id])
    # @subscription = subscription_type.subscriptions.create!(
    #   user_id: @user.id,
    #   start_date: Date.today,
    #   end_date:   Date.today + subscription_type.duration.to_i.days
    # )
    session.delete :subscription_type_id
  end

  def create_payment
    # @payment =
    #   @user
    #   .payments
    #   .create!(
    #     name: @user.name,
    #     address: payment_params[:address],
    #     postal_code_and_city: payment_params[:postal_code_and_city],
    #     subscription_id: @subscription.id
    #   )
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(
      :name,
      :address,
      :postal_code_and_city,
      :subscription_type_id,
      :user_id
    )
  end
end
