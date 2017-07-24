class SubscriptionsController < ApplicationController
  # before_action :set_admin_subscription, only: [:show, :edit, :update, :destroy]
  #
  # # GET /admin/subscriptions
  # # GET /admin/subscriptions.json
  # def index
  #   @admin_subscriptions = Admin::Subscription.all
  # end
  #
  # # GET /admin/subscriptions/1
  # # GET /admin/subscriptions/1.json
  # def show
  # end
  #
  # # GET /admin/subscriptions/new
  # def new
  #   @admin_subscription = Admin::Subscription.new
  # end
  #
  # # GET /admin/subscriptions/1/edit
  # def edit
  # end

  # POST /admin/subscriptions
  # POST /admin/subscriptions.json
  def create
    subscription_params.delete :authenticity_token
    subscription_params.delete :commit
    subscription_params.delete :controller
    subscription_params.delete :action
    redirect_to new_payment_path(subscription_params)

    # @admin_subscription = Admin::Subscription.new(admin_subscription_params)
    #
    # respond_to do |format|
    #   if @admin_subscription.save
    #     format.html { redirect_to @admin_subscription, notice: 'Subscription was successfully created.' }
    #     format.json { render :show, status: :created, location: @admin_subscription }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @admin_subscription.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /admin/subscriptions/1
  # PATCH/PUT /admin/subscriptions/1.json
  # def update
  #   respond_to do |format|
  #     if @admin_subscription.update(admin_subscription_params)
  #       format.html { redirect_to @admin_subscription, notice: 'Subscription was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @admin_subscription }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @admin_subscription.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /admin/subscriptions/1
  # # DELETE /admin/subscriptions/1.json
  # def destroy
  #   @admin_subscription.destroy
  #   respond_to do |format|
  #     format.html { redirect_to admin_subscriptions_url, notice: 'Subscription was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  #
  private

  def subscription_params
    params.permit!
  end
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_admin_subscription
  #     @admin_subscription = Admin::Subscription.find(params[:id])
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def admin_subscription_params
  #     params.require(:admin_subscription).permit(:subscription_type_id, :duration, :start_date, :end_date, :user_id)
  #   end
end
