# frozen_string_literal: true

class Admin::SystemSetupsController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_system_setup, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /admin/system_setups/1/edit
  def edit
  end

  # PATCH/PUT /admin/system_setups/1
  # PATCH/PUT /admin/system_setups/1.json
  def update
    admin_system_setup_params[:administrator_email].delete!(' ')
    if @admin_system_setup.update(admin_system_setup_params)
      redirect_to admin_index_path, notice: 'System opsætningen er opdateret.'
    else
      render :edit
    end
  end

  private

  def set_selected
    @selected = 'system_setups'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_system_setup
    @admin_system_setup = Admin::SystemSetup.find_by(locale: I18n.locale)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_system_setup_params
    params.require(:admin_system_setup).permit(
      :landing_page_id,
      :subscription_page_id,
      :logo,
      :delete_logo,
      :background_color,
      :administrator_email,
      :editor_emails,
      :e_pages_date,
      :last_subscription_id
    )
  end
end
