class Admin::BlogPostCategoriesController < AdminController
  before_action :set_admin_blog_post_category, only: %i[show edit update destroy]

  # GET /admin/blog_post_categories
  def index
    @admin_blog_post_categories =
      Admin::BlogPostCategory
      .where(locale: I18n.locale)
  end

  # GET /admin/blog_post_categories/1
  def show
  end

  # GET /admin/blog_post_categories/new
  def new
    @admin_blog_post_category = Admin::BlogPostCategory.new
  end

  # GET /admin/blog_post_categories/1/edit
  def edit
  end

  # POST /admin/blog_post_categories
  def create
    @admin_blog_post_category = Admin::BlogPostCategory.new(admin_blog_post_category_params)
    @admin_blog_post_category.locale = I18n.locale
    if @admin_blog_post_category.save
      redirect_to @admin_blog_post_category, notice: 'Blog post category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/blog_post_categories/1
  def update
    if @admin_blog_post_category.update(admin_blog_post_category_params)
      redirect_to @admin_blog_post_category, notice: 'Blog post category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/blog_post_categories/1
  def destroy
    @admin_blog_post_category.update_attributes(active: false)
    redirect_to admin_blog_post_categories_url, notice: 'Blog post category was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_blog_post_category
    @admin_blog_post_category = Admin::BlogPostCategory.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_blog_post_category_params
    params
      .require(:admin_blog_post_category)
      .permit(
        :locale,
        :name,
        :page_id
      )
  end
end
