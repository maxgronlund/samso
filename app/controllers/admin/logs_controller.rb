class Admin::LogsController < AdminController
  before_action :set_admin_log, only: %i[show destroy]

  # GET /admin/logs
  def index
    @admin_logs = Admin::Log.order(created_at: :desc).page(params[:page])
  end

  # GET /admin/logs/1
  def show
  end

  # DELETE /admin/logs/1
  def destroy
    @admin_log.destroy
    redirect_to admin_logs_url, notice: 'Log was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_log
      @admin_log = Admin::Log.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_log_params
      params.require(:admin_log).permit(:title, :log_type, :info)
    end
end
