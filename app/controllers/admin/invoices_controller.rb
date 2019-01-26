class Admin::InvoicesController < AdminController
  layout 'invoice'
  def show
    ap @payment = Payment.find_by(uuid: params[:id])
  end

  def index
  end
end
