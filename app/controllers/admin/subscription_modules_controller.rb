class Admin::SubscriptionModulesController < AdminController
  before_action :set_admin_subscription_module, only: [:show, :edit, :update, :destroy]

  # GET /admin/subscription_modules
  # GET /admin/subscription_modules.json
  # def index
  #   @admin_subscription_modules = Admin::SubscriptionModule.all
  # end
  #
  # # GET /admin/subscription_modules/1
  # # GET /admin/subscription_modules/1.json
  # def show
  # end
  #
  # # GET /admin/subscription_modules/new
  # def new
  #   @admin_subscription_module = Admin::SubscriptionModule.new
  # end

  # GET /admin/subscription_modules/1/edit
  def edit
    @page = Page.find(params[:page_id])
  end

  # POST /admin/subscription_modules
  # POST /admin/subscription_modules.json
  # def create
  #   @admin_subscription_module = Admin::SubscriptionModule.new(admin_subscription_module_params)
  #
  #   respond_to do |format|
  #     if @admin_subscription_module.save
  #       format.html { redirect_to @admin_subscription_module, notice: 'Subscription module was successfully created.' }
  #       format.json { render :show, status: :created, location: @admin_subscription_module }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @admin_subscription_module.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /admin/subscription_modules/1
  # PATCH/PUT /admin/subscription_modules/1.json
  def update

    if @admin_subscription_module.update(admin_subscription_module_params)
      @admin_subscription_module.page_module.update_attributes(position: admin_subscription_module_params[:position])
      redirect_to admin_page_path(@admin_subscription_module.admin_page)
    else
      render :edit
    end

  end

  # DELETE /admin/subscription_modules/1
  # DELETE /admin/subscription_modules/1.json
  def destroy
    @admin_subscription_module.destroy
    respond_to do |format|
      format.html { redirect_to admin_subscription_modules_url, notice: 'Subscription module was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_subscription_module
    @admin_subscription_module = Admin::SubscriptionModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_subscription_module_params
    params.require(:admin_subscription_module).permit(:name, :body, :layout, :position)
  end
end
