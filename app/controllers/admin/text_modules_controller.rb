class Admin::TextModulesController < AdminController
  before_action :set_text_module, only: [:show, :edit, :update, :destroy]

  # GET /text_modules/1/edit
  def edit
    @page = Page.find(params[:page_id])
  end

  # PATCH/PUT /text_modules/1
  def update
    if @text_module.update(text_module_params)
      PageModule::Service
        .new(@text_module)
        .update_page_module(text_module_params)
      redirect_to admin_page_path(@text_module.page)
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_text_module
    @text_module = TextModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def text_module_params
    params.require(:text_module).permit(
      :title,
      :body,
      :layout,
      :image,
      :image_size,
      :url,
      :url_text,
      :position,
      :page_id,
      :slot_id,
      :show_to
    )
  end
end
