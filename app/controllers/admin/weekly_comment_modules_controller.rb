class Admin::WeeklyCommentModulesController < AdminController
  before_action :set_admin_weekly_comment_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @weekly_comment_module.update(weekly_comment_module_params)
      @weekly_comment_module
        .update_page_col_module(
          weekly_comment_module_params
        )
      redirect_to admin_page_path(@weekly_comment_module.page)
    else
      render :edit
    end
  end

  def destroy
    @weekly_comment.destroy
    redirect_to admin_weekly_comment_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_weekly_comment_module
    @weekly_comment_module = Admin::WeeklyCommentModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def weekly_comment_module_params
    params.require(:admin_weekly_comment_module).permit(
      :position,
      :name,
      :access_to,
      :articles
    )
  end
end
