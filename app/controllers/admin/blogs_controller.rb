class Admin::BlogsController < AdminController
  before_action :set_admin_blog, only: %i[show edit update, destroy]
  before_action :set_selected

  # GET /admin/blogs
  def index
    @admin_blogs = Admin::Blog.all
  end

  # GET /admin/blogs/1
  def show
  end

  # GET /admin/blogs/new
  def new
    @admin_blog = Admin::Blog.new
  end

  # GET /admin/blogs/1/edit
  def edit
  end

  # POST /admin/blogs
  def create
    @admin_blog = Admin::Blog.new(admin_blog_params)
    @admin_blog.locale = I18n.locale
    if @admin_blog.save
      redirect_to @admin_blog, notice: 'Blog was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/blogs/1
  def update
    if @admin_blog.update(admin_blog_params)
      redirect_to @admin_blog, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/blogs/1
  def destroy
    @admin_blog.destroy
    redirect_to admin_blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_blog
    @admin_blog = Admin::Blog.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_blog_params
    params.require(:admin_blog).permit(:title)
  end

  def set_selected
    @selected = 'blogs'
  end
end
