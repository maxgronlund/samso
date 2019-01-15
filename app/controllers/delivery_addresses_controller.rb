class DeliveryAddressesController < ApplicationController
  include SubscriptionAddressesConcerns


  def create
    @subscription = Admin::Subscription.find(params[:subscription_id])
    @address =
      @subscription
      .addresses
      .new(address_params)
    @address.address_type = Address::TEMPORARY_ADDRESS
    if @address.save

      redirect_to subscription_delivery_addresses_path(@subscription)
    else
      @user = @subscription.user
      render :new
    end
  end

  def update
    if update_address
      address_changed_by(current_user, @address) if @address_changed
      redirect_to subscription_delivery_addresses_path(@subscription)
    else
      @user = @subscription.user
      render :edit
    end
  end

  def destroy
    destroy_address
    redirect_to subscription_delivery_addresses_path(@subscription)
  end
end
