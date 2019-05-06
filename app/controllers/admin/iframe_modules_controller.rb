class Admin::IframeModulesController < AdminController
  before_action :set_admin_iframe_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @iframe_module.update(iframe_module_params)
      @iframe_module
        .update_page_col_module(
          iframe_module_params
        )
      redirect_to admin_page_path(@iframe_module.page)
    else
      render :edit
    end
  end

  def destroy
    @iframe.destroy
    redirect_to admin_iframe_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_iframe_module
    @iframe_module = Admin::IframeModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def iframe_module_params
    params.require(:admin_iframe_module).permit(
      :position,
      :name,
      :access_to,
      :snippet
    )
  end
end
