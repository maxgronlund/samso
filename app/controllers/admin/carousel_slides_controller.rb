class Admin::CarouselSlidesController < AdminController
  before_action :set_admin_carousel_slide, only: [:show, :edit, :update, :destroy]

  # GET /admin/carousel_slides
  # GET /admin/carousel_slides.json
  def index
    @admin_carousel_module = Admin::CarouselModule.find(params[:carousel_module_id])
    @admin_carousel_slides = @admin_carousel_module.slides
  end

  # GET /admin/carousel_slides/1
  # GET /admin/carousel_slides/1.json
  def show
  end

  # GET /admin/carousel_slides/new
  def new
    @admin_carousel_module = Admin::CarouselModule.find(params[:carousel_module_id])
    count = @admin_carousel_module.slides.count
    @admin_carousel_slide = @admin_carousel_module.slides.new(position: count * 10)
  end

  # GET /admin/carousel_slides/1/edit
  def edit
    @admin_carousel_module = Admin::CarouselModule.find(params[:carousel_module_id])
    @admin_carousel_slide = @admin_carousel_module.slides.find(params[:id])
  end

  # POST /admin/carousel_slides
  # POST /admin/carousel_slides.json
  def create
    @admin_carousel_module = Admin::CarouselModule.find(params[:carousel_module_id])
    @admin_carousel_slide  = @admin_carousel_module.slides.new(admin_carousel_slide_params)
    if @admin_carousel_slide.save
      redirect_to show_carousel_path
    else
      render :new
    end
  end

  # PATCH/PUT /admin/carousel_slides/1
  # PATCH/PUT /admin/carousel_slides/1.json
  def update
    @admin_carousel_module = Admin::CarouselModule.find(params[:carousel_module_id])
    if @admin_carousel_slide.update(admin_carousel_slide_params)
      redirect_to show_carousel_path
    else
      render :edit
    end
  end

  # DELETE /admin/carousel_slides/1
  # DELETE /admin/carousel_slides/1.json
  def destroy
    go_to_after_delete = show_carousel_path
    @admin_carousel_slide.destroy
    redirect_to go_to_after_delete
  end

  private

  def show_carousel_path
    admin_page_carousel_module_path(@admin_carousel_slide.parrent_page, @admin_carousel_slide.carousel_module)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_carousel_slide
    @admin_carousel_slide = Admin::CarouselSlide.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_carousel_slide_params
    params.require(:admin_carousel_slide).permit(
      :title,
      :body,
      :position,
      :carousel_module_id,
      :image,
      :page_id
    )
  end
end
