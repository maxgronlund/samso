# frozen_string_literal: true

class Admin::SubscriptionsController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_subscription, only: %i[show edit update destroy]

  # GET /admin/subscriptions
  # GET /admin/subscriptions.json
  def index
    @admin_subscriptions = Admin::Subscription.all
  end

  # GET /admin/subscriptions/1
  # GET /admin/subscriptions/1.json
  def show
  end

  # GET /admin/subscriptions/new
  def new
    @user = User.new
    @user.addresses.build
  end

  # GET /admin/subscriptions/1/edit
  def edit
  end

  # POST /admin/subscriptions
  # POST /admin/subscriptions.json
  def create

    # ap Admin::Subscription.new_subscription_id
    # admin_subscription_params[:validate_address] = true
    @user = User.new(admin_subscription_params)
    @user.addresses.first.name = @user.name
    @user.password_digest = User::Service.fake_password
    @user.validate_email = @user.email.present?
    @user.reset_password_token = SecureRandom.hex(32)
    @user.reset_password_sent_at = Time.zone.now
    if @user.save
    # @user.destroy

      add_member_role
      create_print_type_subscription
      send_welcome_message
      redirect_to admin_show_subscription_id_path(@user.id)
    else
      render :new
    end


    # redirect_back(fallback_location: root_path)
    # @admin_subscription = Admin::Subscription.new(admin_subscription_params)
    # if @admin_subscription.save
    #   redirect_to @admin_subscription
    # else
    #   render :new
    # end
  end

  private

  def create_print_type_subscription
    subscription_type =
      Admin::subscription_type
      .find(admin_system_setup.admin_subscription_type_id)

    @subscription =
      subscription_type
      .subscriptions
      .where(
        user_id: @user.id, 
      )
      first_or_initialize

    @subscription.start_date = Time.zone.now - 1.day
    @subscription.end_date = subscription_type.duration.days
    @subscription.subscription_id = Admin::Subscription.new_subscription_id
    add_address_to_subscription if @subscription.save

  end

  def add_address_to_subscription
    @subscription.copy_user_address unless @subscription.addresses.present?
  end

  def add_member_role
    return if @user.roles.any?

    @user.roles.create
  end

  def send_welcome_message
    
    return if @user.email.blank?

    UserNotifierMailer.welcome_message(@user.id).deliver
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_subscription
    @admin_subscription = Admin::Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_subscription_params

    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :subscribe_to_news,
      addresses_attributes: %i[id name address zipp_code city],
      roles_attributes: %i[permission id]
    )
    
    # params.require(:admin_subscription).permit(
    #   :subscription_type_id,
    #   :duration,
    #   :start_date,
    #   :end_date,
    #   :user_id
    # )
  end
end
