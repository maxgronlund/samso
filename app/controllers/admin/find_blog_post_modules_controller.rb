class Admin::FindBlogPostModulesController < AdminController
  before_action :set_admin_find_blog_post_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @find_blog_post_module.update(find_blog_post_module_params)
      @find_blog_post_module
        .update_page_col_module(
          find_blog_post_module_params
        )
      redirect_to admin_page_path(@find_blog_post_module.page)
    else
      render :edit
    end
  end

  def destroy
    @find_blog_post.destroy
    redirect_to admin_find_blog_post_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_find_blog_post_module
    @find_blog_post_module = Admin::FindBlogPostModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def find_blog_post_module_params
    params.require(:admin_find_blog_post_module).permit(
      :position,
      :name,
      :access_to
    )
  end
end
