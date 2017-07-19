class Admin::SubscriptionTypesController < AdminController
  before_action :set_admin_subscription_type, only: [:show, :edit, :update, :destroy]
  before_action :set_selected

  # GET /admin/subscription_types
  # GET /admin/subscription_types.json
  def index
    @admin_subscription_types = Admin::SubscriptionType.order(:position)
  end

  # GET /admin/subscription_types/1
  # GET /admin/subscription_types/1.json
  def show
  end

  # GET /admin/subscription_types/new
  def new
    @admin_subscription_type = Admin::SubscriptionType.new
  end

  # GET /admin/subscription_types/1/edit
  def edit
  end

  # POST /admin/subscription_types
  # POST /admin/subscription_types.json
  def create
    @admin_subscription_type = Admin::SubscriptionType.new(admin_subscription_type_params)

    if @admin_subscription_type.save
      redirect_to @admin_subscription_type
    else
      render :new
    end
  end

  # PATCH/PUT /admin/subscription_types/1
  # PATCH/PUT /admin/subscription_types/1.json
  def update
    if @admin_subscription_type.update(admin_subscription_type_params)
      redirect_to @admin_subscription_type
    else
      render :edit
    end
  end

  # DELETE /admin/subscription_types/1
  # DELETE /admin/subscription_types/1.json
  def destroy
    @admin_subscription_type.destroy
    redirect_to admin_subscription_types_url
  end

  private

  def set_selected
    @selected = 'subscription_types'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_subscription_type
    @admin_subscription_type = Admin::SubscriptionType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_subscription_type_params
    params.require(:admin_subscription_type).permit(
      :title,
      :body,
      :internet_version,
      :print_version,
      :price,
      :locale,
      :active,
      :duration,
      :position
    )
  end
end
