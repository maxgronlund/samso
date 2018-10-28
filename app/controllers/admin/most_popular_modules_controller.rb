class Admin::MostPopularModulesController < AdminController
  before_action :set_admin_most_popular_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @most_popular_module.update(most_popular_module_params)
      @most_popular_module
        .update_page_col_module(
          most_popular_module_params
        )
      redirect_to admin_page_path(@most_popular_module.page)
    else
      render :edit
    end
  end

  def destroy
    @most_popular.destroy
    redirect_to admin_most_popular_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_most_popular_module
    @most_popular_module = Admin::MostPopularModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def most_popular_module_params
    params.require(:admin_most_popular_module).permit(
      :position,
      :name,
      :access_to
    )
  end
end
