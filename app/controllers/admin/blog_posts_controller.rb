class Admin::BlogPostsController < AdminController
  before_action :set_admin_blog_post, only: %i[show edit update destroy]

  # GET /admin/blog_posts/1
  def show
  end

  # GET /admin/blog_posts/new
  def new
    @admin_blog_module = Admin::BlogModule.find(params[:blog_module_id])
    @admin_blog_post = Admin::BlogPost.new
  end

  # GET /admin/blog_posts/1/edit
  def edit
  end

  # PATCH/PUT /admin/blog_posts/1
  def update
    if @admin_blog_post.update(admin_blog_post_params)
      redirect_to @admin_blog_post
    else
      render :edit
    end
  end

  # DELETE /admin/blog_posts/1
  def destroy
    @admin_blog_post.destroy
    redirect_to admin_blog_posts_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_blog_post
    @page = Page.find(params[:page_id])
    @admin_blog_post = Admin::BlogPost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_blog_post_params
    params
      .require(:admin_blog_post)
      .permit(
        :title,
        :subtitle,
        :body,
        :position,
        :teaser
      )
  end
end
