class SubscriptionAddressesController < ApplicationController
  def edit

    @subscription = Admin::Subscription.find(params[:id])
    ap @subscription_address =
      @subscription
      .subscription_addresses
      .first


    @user = @subscription.user

    render_403 if unpermitted_to_edit?
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
end
