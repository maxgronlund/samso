class SubscriptionsController < ApplicationController
  def new
    subscription_params
  end

  def create
    if user_signed_in?
      redirect_to new_user_payment_path(current_user, subscription_type_id: params[:subscription_type_id])
    else
      redirect_to new_user_path(subscription_type_id: params[:subscription_type_id])
    end
  end
end
