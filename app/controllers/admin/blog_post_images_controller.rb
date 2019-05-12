class Admin::BlogPostImagesController < AdminController
  before_action :set_admin_blog_post_image, only: [:show, :edit, :update, :destroy]

  # GET /admin/blog_post_images
  def index
    @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])
    @admin_blog_post_images =
      @admin_blog_post.blog_post_images
  end

  # # GET /admin/blog_post_images/1
  # def show
  #   @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])
  #   @admin_blog_post_images =
  #     @admin_blog_post.blog_post_images
  # end

  # GET /admin/blog_post_images/new
  def new
    @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])

    @admin_blog_post.blog_post_images.count
    @admin_blog_post_image =
      @admin_blog_post
      .blog_post_images
      .new(
        position: @admin_blog_post.next_image_position
      )
  end

  # GET /admin/blog_post_images/1/edit
  def edit
    @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])
  end

  # POST /admin/blog_post_images
  def create
    @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])
    @admin_blog_post_image =
      @admin_blog_post
      .blog_post_images
      .new(admin_blog_post_image_params)

    if @admin_blog_post_image.save
      redirect_to(
        admin_blog_blog_post_path(
          @admin_blog_post.blog,
          @admin_blog_post
        )
      )
    else
      render :new
    end
  end

  # PATCH/PUT /admin/blog_post_images/1
  def update
    @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])
    if @admin_blog_post_image.update(admin_blog_post_image_params)
      redirect_to(
        admin_blog_blog_post_path(
          @admin_blog_post.blog,
          @admin_blog_post
        )
      )
    else
      render :edit
    end
  end

  # DELETE /admin/blog_post_images/1
  def destroy
    @admin_blog_post_image.destroy
    redirect_to admin_blog_post_images_url, notice: 'Blog post image was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_blog_post_image
      @admin_blog_post_image = Admin::BlogPostImage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_blog_post_image_params
      params.require(:admin_blog_post_image).permit(:image, :image_caption, :admin_blog_post_id, :position)
    end
end
