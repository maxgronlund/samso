class GalleryImagesController < ApplicationController
  before_action :set_image, only: [:edit, :update, :destroy]
  before_action :set_gallery, only: [:new, :create, :edit, :destroy]

  # GET /admin/gallery_images/new
  def new
    @image = @gallery.images.new(position: @gallery.images.count * 10)
  end

  # GET /admin/gallery_images/1/edit
  def edit
    @gallery = @image.gallery_module
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

  # PATCH/PUT /admin/gallery_images/1
  def update
    if @image.update(image_params)
      redirect_to @image.page
    else
      render :edit
    end
  end

  # DELETE /admin/gallery_images/1
  def destroy
    @image.destroy
    redirect_to @gallery.page
  end

  private

  def set_gallery
    @gallery = Admin::GalleryModule.find(params[:gallery_module_id])
    @page    = @gallery.page
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
