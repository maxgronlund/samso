class Admin::FeaturedPostModulesController < AdminController
  before_action :set_admin_featured_post_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @featured_post_module.update(featured_post_module_params)
      @featured_post_module
        .update_page_col_module(
          featured_post_module_params
        )
      redirect_to admin_page_path(@featured_post_module.page)
    else
      render :edit
    end
  end

  def destroy
    @featured_post.destroy
    redirect_to admin_featured_post_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_featured_post_module
    @featured_post_module = Admin::FeaturedPostModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def featured_post_module_params
    params.require(:admin_featured_post_module).permit(
      :position,
      :name,
      :access_to,
      :admin_blog_module_id
    )
  end
end
