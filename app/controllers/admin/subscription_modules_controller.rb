class Admin::SubscriptionModulesController < AdminController
  before_action :set_admin_subscription_module, only: %i[show edit update destroy]

  def edit
    @page = Page.find(params[:page_id])
  end

  def update
    if @subscription_module.update(subscription_module_params)
      PageModule::Service
        .new(@subscription_module)
        .update_page_module(subscription_module_params)
      redirect_to admin_page_path(@subscription_module.page)
    else
      render :edit
    end
  end

  # DELETE /admin/subscription_modules/1
  # DELETE /admin/subscription_modules/1.json
  def destroy
    @subscription_module.destroy
    respond_to do |format|
      format.html { redirect_to admin_subscription_modules_url, notice: 'Subscription module was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_subscription_module
    @subscription_module = Admin::SubscriptionModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_module_params
    params.require(:admin_subscription_module).permit(
      :name,
      :body,
      :layout,
      :position,
      :slot_id
    )
  end
end
