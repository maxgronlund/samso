class GalleryImagesController < ApplicationController
  before_action :set_image, only: %i[edit update destroy]
  before_action :set_gallery_module, only: %i[new create edit destroy]

    # GET /admin/gallery_images/new
  def new
    @image = @gallery.images.new(position: @gallery.images.count * 10)
  end

    # POST /admin/gallery_images
  def create
    @image         = @gallery.images.new(image_params)
    @image.user_id = current_user.id

    if @image.save
      redirect_to @image.page
    else
      render :new
    end
  end

  def show
    @gallery_image = Admin::GalleryImage.find(params[:id])
    @page = @gallery_image.image_page
    @landing_page = landing_page
    render 'pages/show'
  end

    # PATCH/PUT /admin/gallery_images/1
  def update
    if @image.update(image_params)
      redirect_to @image.page
    else
      render :edit
    end
  end

  private

  def set_gallery_module
    @gallery = Admin::GalleryModule.find(params[:gallery_module_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Admin::GalleryImage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:admin_gallery_image).permit(
      :title,
      :body,
      :position,
      :gallery_module_id,
      :image
    )
  end
end
