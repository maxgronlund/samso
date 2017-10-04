class Admin::TextModulesController < AdminController
  before_action :set_text_module, only: %i[show edit update destroy]

  # GET /text_modules/1/edit
  def edit
  end

  # PATCH/PUT /text_modules/1
  def update
    if @text_module.update(text_module_params)
      redirect_to admin_page_path(@text_module.page)
      @text_module.update_position(text_module_params[:position])
      ap @text_module.page.touch
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_text_module
    @text_module = Admin::TextModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # rubocop:disable Metrics/MethodLength
  def text_module_params
    params.require(:admin_text_module).permit(
      :title,
      :body,
      :image,
      :image_ratio,
      :image_style,
      :position,
      :show_to,
      :color,
      :background_color,
      :link_layout,
      :url,
      :url_text,
      :page_id,
      :border
    )
  end
end
