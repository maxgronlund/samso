class Admin::CarouselModulesController < AdminController
  before_action :set_admin_carousel_module, only: [:edit, :update, :destroy, :show]

  def show
    @admin_carousel_slides = @carousel_module.slides.order(:position)
  end

  # GET /admin/carousel_modules/1/edit
  def edit
  end

  # PATCH/PUT /admin/carousel_modules/1
  # PATCH/PUT /admin/carousel_modules/1.json
  def update
    respond_to do |format|
      if @carousel_module.update(admin_carousel_module_params)
        format.html { redirect_to admin_page_path(@page) }
        format.json { render :show, status: :ok, location: @carousel_module }
      else
        format.html { render :edit }
        format.json { render json: @carousel_module.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_carousel_module
    @page = Page.find(params[:page_id])
    @carousel_module = Admin::CarouselModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_carousel_module_params
    params.require(:admin_carousel_module).permit(:name, :layout)
  end
end
