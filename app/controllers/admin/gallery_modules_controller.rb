# frozen_string_literal: true

class Admin::GalleryModulesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_gallery_module, only: %i[show edit update destroy]

  # GET /admin/gallery_modules/1/edit
  def edit
  end

  # PATCH/PUT /admin/gallery_modules/1
  # PATCH/PUT /admin/gallery_modules/1.json
  def update
    if @admin_gallery_module.update(admin_gallery_module_params)
      @admin_gallery_module
        .update_page_col_module(
          admin_gallery_module_params
        )
      redirect_to admin_page_path(@admin_gallery_module.page)
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_gallery_module
    @admin_gallery_module = Admin::GalleryModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_gallery_module_params
    params.require(:admin_gallery_module).permit(
      :name,
      :body,
      :page_id,
      :layout,
      :position,
      :images_pr_page,
      :access_to,
      :color,
      :background_color
    )
  end
end
