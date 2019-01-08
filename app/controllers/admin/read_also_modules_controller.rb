# frozen_string_literal: true

class Admin::ReadAlsoModulesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_read_also_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @read_also_module.update(read_also_module_params)
      @read_also_module
        .update_page_col_module(
          read_also_module_params
        )
      redirect_to admin_page_path(@read_also_module.page)
    else
      render :edit
    end
  end

  def destroy
    @read_also.destroy
    redirect_to admin_read_also_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_read_also_module
    @read_also_module = Admin::ReadAlsoModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def read_also_module_params
    params.require(:admin_read_also_module).permit(
      :position,
      :name,
      :access_to,
      :blog_id,
      :posts_pr_page,
      :show_all_categories,
      :image_on_top
    )
  end
end
