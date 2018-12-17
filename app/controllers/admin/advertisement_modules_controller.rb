# frozen_string_literal: true

class Admin::AdvertisementModulesController < AdminController
  before_action :set_admin_advertisement_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @advertisement_module.update(advertisement_module_params)
      @advertisement_module
        .update_page_col_module(
          advertisement_module_params
        )
      redirect_to admin_page_path(@advertisement_module.page)
    else
      render :edit
    end
  end

  def destroy
    @advertisement.destroy
    redirect_to admin_advertisement_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_advertisement_module
    @advertisement_module = Admin::AdvertisementModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def advertisement_module_params
    params.require(:admin_advertisement_module).permit(
      :position,
      :name,
      :access_to
    )
  end
end
