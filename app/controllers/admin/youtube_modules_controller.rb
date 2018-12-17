# frozen_string_literal: true

class Admin::YoutubeModulesController < AdminController
  before_action :set_admin_youtube_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @youtube_module.update(youtube_module_params)
      @youtube_module.update_position(youtube_module_params[:position])
      redirect_to admin_page_path(@youtube_module.page)
    else
      render :edit
    end
  end

  def destroy
    @youtube.destroy
    redirect_to admin_youtube_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_youtube_module
    @youtube_module = Admin::YoutubeModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def youtube_module_params
    params.require(:admin_youtube_module).permit(
      :position,
      :name,
      :snippet
    )
  end
end
