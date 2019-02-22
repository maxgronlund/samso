class RenewSubscriptionsController < ApplicationController
  include PaymentsConcerns

  def edit
  	params.permit!
  	@subscription = Admin::Subscription.find(params[:id])
    build_form_data(
      user: @subscription.user,
      subscription_type: @subscription.subscription_type
    )  
  end

  def update
  	
  end
end
