# frozen_string_literal: true

class Admin::EPageModulesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_e_page_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @e_page_module.update(e_page_module_params)
      @e_page_module
        .update_page_col_module(
          e_page_module_params
        )
      redirect_to admin_page_path(@e_page_module.page)
    else
      render :edit
    end
  end

  def destroy
    @e_page.destroy
    redirect_to admin_e_page_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_e_page_module
    @e_page_module = Admin::EPageModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def e_page_module_params
    params.require(:admin_e_page_module).permit(
      :position,
      :title,
      :body,
      :access_to,
      :link,
      :image_link
    )
  end
end
