# frozen_string_literal: true

class Admin::SubscriptionsController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_subscription, only: %i[show edit update destroy]

  # GET /admin/subscriptions
  # GET /admin/subscriptions.json
  def index
    @admin_subscriptions = Admin::Subscription.all
  end

  # GET /admin/subscriptions/1
  # GET /admin/subscriptions/1.json
  def show
  end

  # GET /admin/subscriptions/new
  def new
    @admin_subscription = Admin::Subscription.new
  end

  # GET /admin/subscriptions/1/edit
  def edit
  end

  # POST /admin/subscriptions
  # POST /admin/subscriptions.json
  def create
    @admin_subscription = Admin::Subscription.new(admin_subscription_params)
    @admin_subscription.uuid = SecureRandom.uuid
    if @admin_subscription.save
      redirect_to @admin_subscription
    else
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_subscription
    @admin_subscription = Admin::Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_subscription_params
    params.require(:admin_subscription).permit(
      :subscription_type_id,
      :duration,
      :start_date,
      :end_date,
      :user_id
    )
  end
end
