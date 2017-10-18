class Admin::SubscriptionModulesController < AdminController
  before_action :set_admin_subscription_module, only: %i[show edit update destroy]

  def edit
  end

  def update
    if @subscription_module.update(subscription_module_params)
      @subscription_module
        .update_page_col_module(
          subscription_module_params
        )
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
      format.html { redirect_to admin_subscription_modules_url }
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
      :title,
      :body,
      :layout,
      :position,
      :access_to
    )
  end
end
