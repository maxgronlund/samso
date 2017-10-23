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
    @landing_page = admin_system_setup.landing_page
    @subscription_type = Admin::SubscriptionType.find(session[:subscription_type_id])
    @user = User.find(params[:user_id])
    @payment = Payment.new(name: @user.name)
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  def create
    @user = User.find(params[:user_id])
    ActiveRecord::Base.transaction do
      create_subscription
      create_payment
      if @subscription.nil? || @payment.nil?
        raise ActiveRecord::Rollback, 'something went wrong'
      end
    end
    go_to_page
  end

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
    subscription_type =
      Admin::SubscriptionType.find(session[:subscription_type_id])
    @subscription = subscription_type.subscriptions.create!(
      user_id: @user.id,
      start_date: Date.today,
      end_date:   Date.today + subscription_type.duration.to_i.days
    )
    session.delete :subscription_type_id
  end
  # rubocop:enable Metrics/AbcSize

  def create_payment
    @payment =
      @user
      .payments
      .create!(
        name: @user.name,
        address: payment_params[:address],
        postal_code_and_city: payment_params[:postal_code_and_city],
        subscription_id: @subscription.id
      )
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
