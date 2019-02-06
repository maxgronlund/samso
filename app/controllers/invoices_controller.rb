class InvoicesController < ApplicationController
  layout 'invoice'
  def show
    @payment = Payment.find_by(uuid: params[:id])
    render_404 and return if @payment.nil?
    render_403 and return if @payment.user != current_user
  end

  def index
  end
end
