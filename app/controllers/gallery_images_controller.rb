class GalleryImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /admin/gallery_images
  def index
    @admin_gallery_images = Admin::GalleryImage.all
  end

  # GET /admin/gallery_images/1
  def show
  end

  # GET /admin/gallery_images/new
  def new
    @gallery = Admin::GalleryModule.find(params[:gallery_module_id])
    @image = @gallery.images.new(position: @gallery.images.count * 10)
  end

  # GET /admin/gallery_images/1/edit
  def edit
     @gallery       = @image.gallery_module
  end

  # POST /admin/gallery_images
  def create
    @gallery       = Admin::GalleryModule.find(params[:gallery_module_id])
    @image         = @gallery.images.new(image_params)
    @image.user_id = current_user.id
    @page          = @gallery.page

    if @image.save
      redirect_to @page
    else
      render :new
    end
  end

  # PATCH/PUT /admin/gallery_images/1
  def update
    @gallery = @image.gallery_module
    @page    = @gallery.page
    if @image.update(image_params)
      redirect_to @page
    else
      render :edit
    end
  end

  # DELETE /admin/gallery_images/1
  def destroy
    @admin_gallery_image.destroy

    redirect_to admin_gallery_images_url

  end

  private

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
