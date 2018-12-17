# frozen_string_literal: true

class Admin::MenuModulesController < AdminController
  before_action :set_admin_menu_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @menu_module.update(menu_module_params)
      @menu_module
        .update_page_col_module(
          menu_module_params
        )
      @menu_module.update_margin_bottom(menu_module_params[:margin_bottom])
      redirect_to admin_page_path(@menu_module.page)
    else
      render :edit
    end
  end

  def destroy
    @menu.destroy
    redirect_to admin_menu_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_menu_module
    @menu_module = Admin::MenuModule.find(params[:id])
  end

  # Never trust parameters from the scary Internet, only allow the white list through.
  def menu_module_params
    params.require(:admin_menu_module).permit(
      :position,
      :name,
      :menu_content_id,
      :layout,
      :margin_bottom,
      :access_to
    )
  end
end
