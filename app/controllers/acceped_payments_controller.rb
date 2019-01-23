class AccepedPaymentsController < ApplicationController
  def index
    ap params.permit!
    ap params[:onpay_reference]
    ap subscription = Admin::Subscription.find(params[:onpay_reference])
    subscription.accepted!
    ap subscription.user
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
