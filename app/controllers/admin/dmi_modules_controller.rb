class Admin::DmiModulesController < AdminController
  before_action :set_admin_dmi_module, only: %i[show edit update destroy]

  # GET /admin/dmi_modules/1/edit
  def edit
  end

  # PATCH/PUT /admin/dmi_modules/1
  # PATCH/PUT /admin/dmi_modules/1.json
  def update
    if @dmi_module.update(dmi_module_params)
      PageModule::Service
        .new(@dmi_module)
        .update_page_module(dmi_module_params)
      redirect_to admin_page_path(@dmi_module.page)
    else
      render :edit
    end
  end

  # DELETE /admin/dmi_modules/1
  def destroy
    @dmi_module.destroy
    redirect_to admin_dmi_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_dmi_module
    @page = Page.find(params[:page_id])
    @dmi_module = Admin::DmiModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dmi_module_params
    params.require(:admin_dmi_module).permit(
      :forecast_duration,
      :position,
      :slot_id
    )
  end
end
