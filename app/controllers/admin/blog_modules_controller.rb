class Admin::BlogModulesController < AdminController
  before_action :set_admin_blog_module, only: %i[edit update]

  # GET /admin/blog_modules/1/edit
  def edit
  end

  # PATCH/PUT /admin/blog_modules/1
  def update
    if @admin_blog_module.update(admin_blog_module_params)
      PageModule::Service
        .new(@admin_blog_module)
        .update_page_module(admin_blog_module_params)
      redirect_to admin_page_path(@admin_blog_module.page)
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_blog_module
    @page = Page.find(params[:page_id])
    @admin_blog_module = Admin::BlogModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_blog_module_params
    params.require(:admin_blog_module).permit(
      :name,
      :body,
      :layout,
      :position,
      :slot_id,
      :post_page_id
    )
  end
end
