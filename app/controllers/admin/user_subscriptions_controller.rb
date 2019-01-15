# frozen_string_literal: true

class Admin::UserSubscriptionsController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_user, only: %i[new create edit update]

  def new
    @subscription =
      @user
      .subscriptions
      .new(end_date: Time.zone.now + 1.month)
  end

  def create
    subscription_type = Admin::SubscriptionType.free_subscription
    subscription =
      @user
      .subscriptions
      .new(subscription_params)
    subscription.subscription_type_id = subscription_type.id
    subscription.subscription_id = Admin::Subscription.new_subscription_id
    subscription.save
    subscription.set_address
    @user.update(legacy_subscription_id: subscription.subscription_id)
    redirect_to admin_user_path(@user)
  end

  def edit
    ap subscription
  end

  def update
    subscription.update!(subscription_params)
    redirect_to admin_user_path(@user)
  end

  private

  def subscription
    @subscription ||=
      Admin::Subscription.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def subscription_params
    params[:admin_subscription]
      .permit(:start_date, :end_date)
  end
end
