class AccepedPaymentsController < ApplicationController
  def index
    params.permit!
    subscription = Admin::Subscription.find(params[:onpay_reference])
    subscription.accepted!
    redirect_to default_path(root_url)
  end

  def new
    # ap params
  end

  def create
    # ap params
  end

  def show
    # ap params
  end

  def edit
    # ap params
  end

  def destroy
    # ap params
  end
end
