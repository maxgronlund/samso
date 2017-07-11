class PaymentsController < ApplicationController

  def new
    Admin::SubscriptionType.find(payment_params[:subscription_type_id])
    @payment = Payment.new
    find_page
  end

  def create
  end

  def show
  end

  private

  def find_page
    if session[:page_id]
      @page = Page.find(session[:page_id])
    else
      @page = false
    end
  end


  private

  def payment_params
    params.permit!
  end

end
