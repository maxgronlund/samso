class SubscriptionAddressesController < ApplicationController
  def show
    @subscription = Admin::Subscription.find(params[:id])
    @user = @subscription.user
  end
  def edit
    @subscription = Admin::Subscription.find(params[:id])
    @address = @subscription.primary_address
    @user = @subscription.user
    render_403 if unpermitted_to_edit?
  end

  def update
    @subscription = Admin::Subscription.find(address_params[:id])
    address = @subscription.primary_address
    address.update(address_params[:address])
    redirect_to user_path(@subscription.user_id)
  end

  private

  def unpermitted_to_edit?
    !permitted_to_edit?
  end

  def permitted_to_edit?
    user_signed_in? && user_can_edit_subscription_address?
  end

  def user_can_edit_subscription_address?
    current_user.administrator? || @user == current_user
  end

  def address_params
    # ap params.require(:address).permit(:user_id, :name, :address, :zipp_code, :city)
    params.permit!
  end
end
