# frozen_string_literal: true

class Admin::CalendarModulesController < AdminController
  before_action :set_admin_calendar_module, only: %i[edit update destroy]

  def edit
  end

  def update
    if @calendar_module.update(calendar_module_params)
      @calendar_module
        .update_page_col_module(
          calendar_module_params
        )
      redirect_to admin_page_path(@calendar_module.page)
    else
      render :edit
    end
  end

  def destroy
    @calendar.destroy
    redirect_to admin_calendar_modules_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_calendar_module
    @calendar_module = Admin::CalendarModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def calendar_module_params
    params.require(:admin_calendar_module).permit(
      :position,
      :name,
      :admin_calendar_id,
      :access_to,
      :layout
    )
  end
end
