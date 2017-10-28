class Admin::BlogPostsController < AdminController
  before_action :set_admin_blog_post, only: %i[show edit update destroy]

  # GET /admin/blog_posts/1
  def show
  end

  # GET /admin/blog_posts/new
  def new
    @admin_blog = Admin::Blog.find(params[:blog_id])
    @admin_blog_post = Admin::BlogPost.new
  end

  # POST /admin/posts
  def create
    @admin_blog = Admin::Blog.find(params[:blog_id])
    @blog_post = @admin_blog.posts.new(admin_blog_post_params)
    @blog_post.user = current_user
    if @blog_post.save!
      # @admin_blog.clear_cache_on_pages
      update_blog_post_count(nil, @blog_post.admin_blog_post_category_id)
      # @blog_module.clear_page_cache
      redirect_to admin_blog_path(@admin_blog)
    else
      render :new
    end
  end

  # GET /admin/blog_posts/1/edit
  def edit
  end

  # PATCH/PUT /admin/blog_posts/1
  def update
    old_category_id = @admin_blog_post.admin_blog_post_category_id
    if @admin_blog_post.update(admin_blog_post_params)
      update_blog_post_count(old_category_id, @admin_blog_post.admin_blog_post_category_id)
      # @admin_blog.clear_cache_on_pages
      redirect_to admin_articles_path
    else
      render :edit
    end
  end

  # DELETE /admin/blog_posts/1
  def destroy
    @admin_blog_post.destroy
    redirect_to admin_blog_url(@admin_blog)
  end

  private

  def update_blog_post_count(old_category_id, new_category_id)
    Admin::BlogPostCategory.update_blog_post_count(old_category_id, new_category_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_blog_post
    @admin_blog = Admin::Blog.find(params[:blog_id])
    @admin_blog_post = Admin::BlogPost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # rubocop:disable Metrics/MethodLength
  def admin_blog_post_params
    params
      .require(:admin_blog_post)
      .permit(
        :title,
        :body,
        :position,
        :image,
        :teaser,
        :subtitle,
        :image,
        :blog_module_id,
        :page_id,
        :admin_blog_post_category_id,
        :image,
        :free_content,
        :featured,
        :admin_blog_post_category_id
      )
  end
end
