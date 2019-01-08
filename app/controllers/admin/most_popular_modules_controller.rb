# frozen_string_literal: true

class Admin::MostPopularModulesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_most_popular_module, only: %i[edit update destroy]

  def edit
    @most_popular_module.update(name: default_name) if @most_popular_module.name.blank?
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

  def default_name
    t('most_popular_module.default_name')
  end
end
