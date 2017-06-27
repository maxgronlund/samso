class Admin::SystemSetupsController < ApplicationController
  before_action :set_admin_system_setup, only: [:show, :edit, :update, :destroy]

  # GET /admin/system_setups/1/edit
  def edit
  end

  # PATCH/PUT /admin/system_setups/1
  # PATCH/PUT /admin/system_setups/1.json
  def update
    respond_to do |format|
      if @admin_system_setup.update(admin_system_setup_params)
        format.html { redirect_to @admin_system_setup, notice: 'System setup er opdateret.' }
        format.json { render :show, status: :ok, location: @admin_system_setup }
      else
        format.html { render :edit }
        format.json { render json: @admin_system_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_system_setup
    @admin_system_setup = Admin::SystemSetup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_system_setup_params
    params.require(:admin_system_setup).permit(:maintenance)
  end
end
