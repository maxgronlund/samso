# frozen_string_literal: true

class Admin::UserSubscriptionsController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_user, only: %i[new create edit update]

  def new
    @subscription =
      @user
      .subscriptions
      .new(
        end_date: Time.zone.now + 1.month
      )
  end

  def create
    # subscription_type = Admin::SubscriptionType.free

    subscription =
      @user
      .subscriptions
      .new(subscription_and_address_params)
    subscription.save!
    redirect_to admin_user_path(@user)
  end

  def edit
    subscription
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

  def subscription_and_address_params
    prms = subscription_params.dup
    prms[:subscription_id] = Admin::Subscription.new_subscription_id
    prms[:addresses] = [Address.new(address_params)]
    prms
  end

  def address_params
    address = user_address.attributes
    address.delete('id')
    address.delete('addressable_type')
    address.delete('addressable_id')
    address.delete('created_at')
    address[:last_name] = '-' if address[:last_name].blank?
    address
  end

  def user_address
    address = @user.address
    address.set_defaults unless address.valid_address?
    address.save
    address
  end

  def subscription_params
    params[:admin_subscription]
      .permit(:start_date, :end_date, :subscription_type_id, :subscription_type_id)
  end
end
