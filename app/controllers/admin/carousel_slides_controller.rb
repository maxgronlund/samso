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
    @admin_carousel_slide = @admin_carousel_module.slides.new
  end

  # GET /admin/carousel_slides/1/edit
  def edit
    @admin_carousel_module = Admin::CarouselModule.find(params[:carousel_module_id])
  end

  # POST /admin/carousel_slides
  # POST /admin/carousel_slides.json
  def create
    ap admin_carousel_slide_params
    #@admin_carousel_slide = Admin::CarouselSlide.new(admin_carousel_slide_params)

    @admin_carousel_module = Admin::CarouselModule.find(params[:carousel_module_id])
    @admin_carousel_slide = @admin_carousel_module.slides.new(admin_carousel_slide_params)

    respond_to do |format|
      if @admin_carousel_slide.save
        format.html { redirect_to @admin_carousel_slide, notice: 'Carousel slide was successfully created.' }
        format.json { render :show, status: :created, location: @admin_carousel_slide }
      else
        format.html { render :new }
        format.json { render json: @admin_carousel_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/carousel_slides/1
  # PATCH/PUT /admin/carousel_slides/1.json
  def update
    respond_to do |format|
      if @admin_carousel_slide.update(admin_carousel_slide_params)
        format.html { redirect_to @admin_carousel_slide, notice: 'Carousel slide was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_carousel_slide }
      else
        format.html { render :edit }
        format.json { render json: @admin_carousel_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/carousel_slides/1
  # DELETE /admin/carousel_slides/1.json
  def destroy
    @admin_carousel_slide.destroy
    respond_to do |format|
      format.html { redirect_to admin_carousel_slides_url, notice: 'Carousel slide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_carousel_slide
      @admin_carousel_slide = Admin::CarouselSlide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_carousel_slide_params
      params.require(:admin_carousel_slide).permit(:title, :body, :position, :carousel_module_id)
    end
end
