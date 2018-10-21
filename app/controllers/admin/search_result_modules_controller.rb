class Admin::SearchResultModulesController < AdminController
  before_action :set_admin_search_result_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @search_result_module.update(search_result_module_params)
      @search_result_module
        .update_page_col_module(
          search_result_module_params
        )
      redirect_to admin_page_path(@search_result_module.page)
    else
      render :edit
    end
  end

  def destroy
    @search_result.destroy
    redirect_to admin_search_result_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_search_result_module
    @search_result_module = Admin::SearchResultModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def search_result_module_params
    params.require(:admin_search_result_module).permit(
      :position,
      :name,
      :access_to
    )
  end
end
