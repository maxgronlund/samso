class Admin::BlogPostsController < AdminController
  before_action :set_admin_blog_post, only: %i[show edit update destroy]

  # GET /admin/blog_posts
  # GET /admin/blog_posts.json
  # def index
  #   @admin_blog_posts = Admin::BlogPost.all
  # end

  # GET /admin/blog_posts/1
  # GET /admin/blog_posts/1.json
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

  # POST /admin/blog_posts
  # POST /admin/blog_posts.json
  def create
    @admin_blog_module  = Admin::BlogModule.find(params[:blog_module_id])
    @admin_blog_post    = @admin_blog_module.posts.new(admin_blog_post_params)
    if @admin_blog_post.save
      redirect_to admin_page_path(@admin_blog_module.page)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/blog_posts/1
  # PATCH/PUT /admin/blog_posts/1.json
  def update
    respond_to do |format|
      if @admin_blog_post.update(admin_blog_post_params)
        format.html { redirect_to @admin_blog_post, notice: 'Blog post was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_blog_post }
      else
        format.html { render :edit }
        format.json { render json: @admin_blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/blog_posts/1
  # DELETE /admin/blog_posts/1.json
  def destroy
    @admin_blog_post.destroy
    respond_to do |format|
      format.html { redirect_to admin_blog_posts_url, notice: 'Blog post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_blog_post
    @page = Page.find(params[:page_id])
    @admin_blog_post = Admin::BlogPost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_blog_post_params
    params.require(:admin_blog_post).permit(:title, :body, :position, :teaser)
  end
end
