class Admin::SubscriptionAddressesController < AdminController
  include SubscriptionAddressesConcerns

  def destroy
    address = Address.find(params[:id])
    subscription = address.subscription
    address.destroy
    redirect_to admin_subscription_address_path(subscription)
  end
end
