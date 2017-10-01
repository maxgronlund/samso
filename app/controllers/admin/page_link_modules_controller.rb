class Admin::PageLinkModulesController < AdminController
  before_action :set_admin_page_link_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @page_link_module.update(page_link_module_params)
      @page_link_module.update_position(page_link_module_params[:position])
      redirect_to admin_page_path(@page_link_module.page)
    else
      render :edit
    end
  end


  def destroy
    @page_link.destroy
    redirect_to admin_page_link_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_page_link_module
    @page_link_module = Admin::PageLinkModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_link_module_params
    params.require(:admin_page_link_module).permit(
      :position,
      :name
    )
  end
end
