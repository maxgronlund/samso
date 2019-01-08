# frozen_string_literal: true

class Admin::CarouselModulesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_carousel_module, only: %i[edit update destroy show]

  def show
    @admin_carousel_slides =
      @carousel_module
      .slides
      .order(:position)
  end

  # GET /admin/carousel_modules/1/edit
  def edit
  end

  # PATCH/PUT /admin/carousel_modules/1
  # PATCH/PUT /admin/carousel_modules/1.json
  def update
    if @carousel_module.update(carousel_module_params)
      @carousel_module
        .update_page_col_module(
          carousel_module_params
        )
      redirect_to admin_carousel_module_path(@carousel_module)
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_carousel_module
    @carousel_module = Admin::CarouselModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def carousel_module_params
    params.require(:admin_carousel_module).permit(
      :name,
      :layout,
      :position,
      :access_to
    )
  end
end
