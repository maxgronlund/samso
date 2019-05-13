class Admin::BlogPostImagesController < AdminController
  before_action :set_admin_blog_post_image, only: %w[show edit update destroy]
  before_action :set_admin_blog_post, only: %w[index new create edit update destroy]

  # GET /admin/blog_post_images
  def index
    @admin_blog_post_images =
      @admin_blog_post.blog_post_images
  end

  # GET /admin/blog_post_images/new
  def new
    @admin_blog_post_image =
      @admin_blog_post
      .blog_post_images
      .new(
        position: @admin_blog_post.next_image_position
      )
  end

  # GET /admin/blog_post_images/1/edit
  def edit
  end

  # POST /admin/blog_post_images
  def create
    @admin_blog_post_image =
      @admin_blog_post
      .blog_post_images
      .new(admin_blog_post_image_params)

    if @admin_blog_post_image.save
      bounce_back
    else
      render :new
    end
  end

  # PATCH/PUT /admin/blog_post_images/1
  def update
    if @admin_blog_post_image.update(admin_blog_post_image_params)
      bounce_back
    else
      render :edit
    end
  end

  # DELETE /admin/blog_post_images/1
  def destroy
    @admin_blog_post_image.destroy
    bounce_back
  end

  private

  def bounce_back
    redirect_to(
      admin_blog_post_blog_post_images_path(
        @admin_blog_post
      )
    )
  end

  def set_admin_blog_post
    @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_blog_post_image
      @admin_blog_post_image = Admin::BlogPostImage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_blog_post_image_params
      params.require(:admin_blog_post_image).permit(:image, :image_caption, :admin_blog_post_id, :position)
    end
end
