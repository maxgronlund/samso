class Admin::ImageModulesController < AdminController
  before_action :set_admin_image_module, only: %i[show edit update destroy]

  # GET /admin/image_modules/1/edit
  def edit
  end

  # PATCH/PUT /admin/image_modules/1
  def update
    if @admin_image_module.update(admin_image_module_params)
      PageModule::Service
        .new(@admin_image_module)
        .update_page_module(admin_image_module_params)
      redirect_to admin_page_path(@admin_image_module.page)
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_image_module
    @admin_image_module = Admin::ImageModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_image_module_params
    params.require(:admin_image_module).permit(
      :layout,
      :page_id,
      :position,
      :slot_id
    )
  end
end
