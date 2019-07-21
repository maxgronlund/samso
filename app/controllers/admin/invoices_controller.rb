class Admin::InvoicesController < AdminController
  layout 'invoice', only: [:show]
  def show
    @payment = Payment.find_by(uuid: params[:id])
  end

  def index
    if params[:search].present?
      @invoices = Payment.search(params[:search]).page(params[:page])
    else
      @invoices = Payment.page params[:page]
    end
  end
end
