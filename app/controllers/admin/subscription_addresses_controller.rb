class Admin::SubscriptionAddressesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  include SubscriptionAddressesConcerns

  def destroy
    address = Address.find(params[:id])
    subscription = address.subscription
    address.destroy
    redirect_to admin_subscription_address_path(subscription)
  end
end
