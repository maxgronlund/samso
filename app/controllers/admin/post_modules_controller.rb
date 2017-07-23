class Admin::PostModulesController < AdminController
  before_action :set_admin_post_module, only: [:edit, :update, :destroy]

  # GET /admin/post_modules/1/edit
  def edit
    @page = Page.find(params[:page_id])
  end

  # PATCH/PUT /admin/post_modules/1
  # PATCH/PUT /admin/post_modules/1.json
  def update
    if @admin_post_module.update(admin_post_module_params)
      redirect_to admin_page_path(@admin_post_module.page)
    else
      format.html { render :edit }
    end
  end

  # DELETE /admin/post_modules/1
  # DELETE /admin/post_modules/1.json
  def destroy
    @admin_post_module.destroy
    redirect_to admin_post_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_post_module
    @admin_post_module = Admin::PostModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_post_module_params
    params.require(:admin_post_module).permit(:name)
  end
end
