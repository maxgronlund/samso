class Admin::VerticalMenuModulesController < AdminController
  before_action :set_admin_vertical_menu_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @vertical_menu_module.update(vertical_menu_module_params)
      @vertical_menu_module.update_position(vertical_menu_module_params[:position])
      redirect_to admin_page_path(@vertical_menu_module.page)
    else
      render :edit
    end
  end


  def destroy
    @vertical_menu.destroy
    redirect_to admin_vertical_menu_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_vertical_menu_module
    @vertical_menu_module = Admin::VerticalMenuModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vertical_menu_module_params
    params.require(:admin_vertical_menu_module).permit(
      :position,
      :name,
      :vertical_menu_content_id
    )
  end
end
