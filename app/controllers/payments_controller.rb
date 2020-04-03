class PaymentsController < ApplicationController
  include PaymentsConcerns

  # GET /payments/new
  def new
    subscription_type_id = session[:subscription_type_id] || params[:subscription_type_id]
    @subscription_type = Admin::SubscriptionType.find(subscription_type_id)
    # if @subscription_type.nil?
    #   render_404
    #   return
    # end
    @user = User.find(params[:user_id])

    build_form_data(
      user: @user,
      subscription_type: @subscription_type,
      payable_type: 'Admin::Subscription'
    )
  rescue => e
    render_404
    return
  end
end
