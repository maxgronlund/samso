class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    if user_signed_in?
      @payment = Payment.new(name: current_user.name)
      @subscription_type_id = params[:subscription_type_id]
    else
      session[:new_payment_path] = new_payment_path(
        subscription_type_id: params[:subscription_type_id]
      )
      redirect_to new_user_registration_path
    end
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create

    ActiveRecord::Base.transaction do
      create_subscription
      create_payment

      if @subscription.nil? ||  @payment.nil?
        raise ActiveRecord::Rollback, 'something went wrong'
      end
    end

    if session[:page_id]
      redirect_to page_path(session[:page_id])
    else
      redirect_to root_path
    end
  end

  def create_subscription
    @subscription_type =
      Admin::SubscriptionType.find(
        payment_params_with_user_id[:subscription_type_id]
      )
    @subscription = @subscription_type.subscriptions.create(
      user_id:    current_user.id,
      duration:   @subscription_type.duration,
      start_date: Date.today,
      end_date:   Date.today + @subscription_type.duration.to_i.days
    )
  end

  def create_payment
    ap valid_payment_params
    @payment = Payment.new(valid_payment_params)
    @payment.subscription_id = @subscription.id
    @payment.name = @subscription_type.title
    @payment.save
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  #def update
  #  respond_to do |format|
  #    if @payment.update(payment_params)
  #      format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @payment }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @payment.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /payments/1
  # DELETE /payments/1.json
  # def destroy
  #   @payment.destroy
  #   respond_to do |format|
  #     format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def valid_payment_params
    params_copy = payment_params_with_user_id.dup
    params_copy.delete :subscription_type_id
    params_copy
  end


  def payment_params_with_user_id
    params_copy = payment_params.dup
    params_copy[:user_id] = current_user.id
    params_copy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(
      :name,
      :email,
      :address,
      :postal_code_and_city,
      :password,
      :password_confirmation,
      :news_letter,
      :subscription_type_id,
      :user_id)
  end
end
