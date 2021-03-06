# frozen_string_literal: true

class Admin::PostModulesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_post_module, only: %i[edit update destroy]

  # GET /admin/post_modules/1/edit
  def edit
  end

  # PATCH/PUT /admin/post_modules/1
  # PATCH/PUT /admin/post_modules/1.json
  def update
    if @post_module.update(post_module_params)
      @post_module
        .update_page_col_module(
          post_module_params
        )
      redirect_to admin_page_path(@post_module.page)
    else
      format.html { render :edit }
    end
  end

  # DELETE /admin/post_modules/1
  # DELETE /admin/post_modules/1.json
  def destroy
    @post_module.destroy
    redirect_to admin_post_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_post_module
    @post_module = Admin::PostModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_module_params
    params.require(:admin_post_module).permit(
      :name,
      :position,
      :access_to
    )
  end
end
