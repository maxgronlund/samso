class AccepedPaymentsController < ApplicationController
  

  def index
    params.permit!
    @subscription = Admin::Subscription.find(params[:onpay_reference])

    @subscription.accepted!
    redirect_to default_path(root_url)
  end

end
