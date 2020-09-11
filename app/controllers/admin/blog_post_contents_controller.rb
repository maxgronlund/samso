class Admin::BlogPostContentsController < AdminController
  before_action :set_admin_blog_post_content, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_blog_post, only: %w[index new create edit update destroy]
  # GET /admin/blog_post_contents
  # GET /admin/blog_post_contents.json
  def index
    @admin_blog_post_contents = Admin::BlogPostContent.all
  end

  # GET /admin/blog_post_contents/1
  # GET /admin/blog_post_contents/1.json
  def show
  end

  # GET /admin/blog_post_contents/new
  def new
    @admin_blog_post_content =
      @admin_blog_post
      .blog_post_contents
      .new(
        position: @admin_blog_post.next_content_position
      )
  end

  # GET /admin/blog_post_contents/1/edit
  def edit
  end

  # POST /admin/blog_post/:id/blog_post_contents
  def create
    @admin_blog_post_content =
      @admin_blog_post
      .blog_post_contents
      .new(admin_blog_post_content_params)

    if @admin_blog_post_content.save
      redirect_to(admin_blog_blog_post_path(@admin_blog_post.blog, @admin_blog_post))
    else
      render :new
    end
  end

  # PATCH/PUT /admin/blog_post_contents/1
  # PATCH/PUT /admin/blog_post_contents/1.json
  # def update
  #   respond_to do |format|
  #     if @admin_blog_post_content.update(admin_blog_post_content_params)
  #       format.html { redirect_to @admin_blog_post_content, notice: 'Blog post content was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @admin_blog_post_content }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @admin_blog_post_content.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /admin/blog_post_images/1
  def update
    if @admin_blog_post_content.update(admin_blog_post_content_params)
      redirect_to(admin_blog_blog_post_path(@admin_blog_post.blog, @admin_blog_post))
    else
      render :edit
    end
  end

  # DELETE /admin/blog_post_contents/1
  # DELETE /admin/blog_post_contents/1.json
  def destroy
    @admin_blog_post_content.destroy
    respond_to do |format|
      format.html { redirect_to admin_blog_post_contents_url, notice: 'Blog post content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_admin_blog_post
      @admin_blog_post = Admin::BlogPost.find(params[:blog_post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_blog_post_content
      @admin_blog_post_content = Admin::BlogPostContent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_blog_post_content_params
      params.require(:admin_blog_post_content).permit(:title, :body, :image, :image_caption, :position, :admin_blog_post_id)
    end
end
