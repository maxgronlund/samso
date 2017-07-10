class Admin::TextModulesController < AdminController
  before_action :set_text_module, only: [:show, :edit, :update, :destroy]

  # GET /text_modules/1/edit
  def edit
    @page = Page.find(params[:page_id])
    # @alfa_romeo_mock = {
    #   title: DummyData::TITLE,
    #   body: DummyData::LIPSUM,
    #   image: 'text_module/640x240.png',
    #   url: 'https://google.com',
    #   url_text: 'google'}
    #   @aston_martin_mock = @alfa_romeo_mock
    #   @aston_martin_mock[:image] = 'text_module/size_480_480.png'
  end

  # PATCH/PUT /text_modules/1
  # PATCH/PUT /text_modules/1.json
  def update
    if @text_module.update(text_module_params)
      @text_module.page_module.update_attributes(position: text_module_params[:position])
      redirect_to admin_page_path(@text_module.admin_page)
    else
      render :edit
    end
  end

  # DELETE /text_modules/1
  # DELETE /text_modules/1.json
  def destroy
    @text_module.destroy
    respond_to do |format|
      format.html { redirect_to text_modules_url }
      format.json { head :no_content }
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
      :position
    )
  end
end
