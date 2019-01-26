class SubscriptionsController < ApplicationController
  def new
    subscription_params
  end

  # rubocop:disable Metrics/AbcSize
  def create
    subscription_params.delete :authenticity_token
    subscription_params.delete :commit
    subscription_params.delete :controller
    subscription_params.delete :action
    session[:subscription_type_id] = params[:subscription_type_id]
    subscription_type = Admin::SubscriptionType.find(params[:subscription_type_id])
    print_version = subscription_type.print_version
    if user_signed_in?
      redirect_to new_user_payment_path(current_user)
    else
      redirect_to new_user_path
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def subscription_params
    params.permit!
  end
end
