class Admin::SystemSetupsController < ApplicationController
  before_action :set_admin_system_setup, only: [:show, :edit, :update, :destroy]

  # GET /admin/system_setups
  # GET /admin/system_setups.json
  def index
    @admin_system_setups = Admin::SystemSetup.all
  end

  # GET /admin/system_setups/1
  # GET /admin/system_setups/1.json
  def show
  end

  # GET /admin/system_setups/new
  def new
    @admin_system_setup = Admin::SystemSetup.new
  end

  # GET /admin/system_setups/1/edit
  def edit
  end

  # POST /admin/system_setups
  # POST /admin/system_setups.json
  def create
    @admin_system_setup = Admin::SystemSetup.new(admin_system_setup_params)

    respond_to do |format|
      if @admin_system_setup.save
        format.html { redirect_to @admin_system_setup, notice: 'System setup was successfully created.' }
        format.json { render :show, status: :created, location: @admin_system_setup }
      else
        format.html { render :new }
        format.json { render json: @admin_system_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/system_setups/1
  # PATCH/PUT /admin/system_setups/1.json
  def update
    respond_to do |format|
      if @admin_system_setup.update(admin_system_setup_params)
        format.html { redirect_to @admin_system_setup, notice: 'System setup was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_system_setup }
      else
        format.html { render :edit }
        format.json { render json: @admin_system_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/system_setups/1
  # DELETE /admin/system_setups/1.json
  def destroy
    @admin_system_setup.destroy
    respond_to do |format|
      format.html { redirect_to admin_system_setups_url, notice: 'System setup was successfully destroyed.' }
      format.json { head :no_content }
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
