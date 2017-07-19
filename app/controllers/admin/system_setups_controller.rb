class Admin::SystemSetupsController < AdminController
  before_action :set_admin_system_setup, only: [:show, :edit, :update, :destroy]
  before_action :set_selected

  # GET /admin/system_setups/1/edit
  def edit
  end

  # PATCH/PUT /admin/system_setups/1
  # PATCH/PUT /admin/system_setups/1.json
  def update
    # UserNotifierMailer.send_signup_email(User.find_by(email: 'max@synthmax.dk')).deliver
    respond_to do |format|
      if @admin_system_setup.update(admin_system_setup_params)
        format.html { redirect_to admin_index_path, notice: 'System setup er opdateret.' }
        format.json { render :show, status: :ok, location: @admin_system_setup }
      else
        format.html { render :edit }
        format.json { render json: @admin_system_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_selected
    @selected = 'system_setups'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_system_setup
    @admin_system_setup = Admin::SystemSetup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_system_setup_params
    params.require(:admin_system_setup).permit(
      :da_landing_page_id,
      :da_subscription_page_id,
      :en_landing_page_id,
      :en_subscription_page_id
    )
  end
end
