class Admin::EPageFreeModulesController < AdminController
  before_action :set_admin_e_page_free_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @e_page_free_module.update(e_page_free_module_params)
      @e_page_free_module
        .update_page_col_module(
          e_page_free_module_params
        )
      redirect_to admin_page_path(@e_page_free_module.page)
    else
      render :edit
    end
  end

  def destroy
    @e_page_free.destroy
    redirect_to admin_e_page_free_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_e_page_free_module
    @e_page_free_module = Admin::EPageFreeModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def e_page_free_module_params
    params.require(:admin_e_page_free_module).permit(
      :position,
      :title,
      :body,
      :access_to,
      :link,
      :image_link
    )
  end
end
