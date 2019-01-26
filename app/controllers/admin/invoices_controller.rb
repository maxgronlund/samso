class Admin::InvoicesController < AdminController
  layout 'invoice'
  def show
    @payment = Payment.find_by(uuid: params[:id])
  end
end
