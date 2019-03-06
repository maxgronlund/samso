class RenewSubscriptionsController < ApplicationController
  include PaymentsConcerns

  def edit
    params.permit!
    @subscription = Admin::Subscription.find(params[:id])
    @subscription_type = @subscription.subscription_type
    build_form_data(
      user: @subscription.user,
      subscription_type: @subscription_type,
      payable_id: @subscription.id,
      payable_type: @subscription.class.name
    )
  end

  def update
  end
end
