class SubscriptionAddressesController < ApplicationController
  include SubscriptionAddressesConcerns

  def edit
    @address = Address.find(params[:id])
    @subscription = @address.subscription
    @user = @subscription.user
    render_403 if unpermitted_to_edit?
  end

  def update
    @address = Address.find(params[:id])
    subscription = @address.subscription
    @address.update(address_params[:address])
    redirect_to subscription_address_path(subscription)
  end

end
