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


  def edit
  end

  def create
    ap subscription_params
    @user = User.new(subscription_params)
    @user.addresses.first.name = @user.name
    @user.password_digest = User::Service.fake_password
    @user.uuid = SecureRandom.uuid
    @user.reset_password_token = SecureRandom.hex(32)
    @user.reset_password_sent_at = Time.zone.now
    @user.roles = [Role.new]
    @user.subscriptions = [new_subscription]
    if @user.save
      send_welcome_message
      redirect_to admin_show_subscription_id_path(@user.id)
    else
      render :new
    end
  end

  def destroy
    user = @admin_subscription.user
    @admin_subscription.expire!
    redirect_to default_path(admin_user_path(user))
  end

  private

  def new_subscription
    subscription_type = Admin::SubscriptionType.from_economics

    Admin::Subscription.new(
      start_date: Time.zone.now,
      end_date: Time.zone.now + subscription_type.duration.days,
      subscription_type_id: subscription_type.id,
      subscription_id: Admin::Subscription.new_subscription_id,
      addresses: [subscription_address]
    )
  end

  def subscription_address
    address = admin_subscription_params[:addresses_attributes]['0']
    Address.new(
      addressable_type: 'Admin::Subscription',
      name: admin_subscription_params[:name],
      address: address[:address],
      zipp_code: address[:zipp_code],
      city: address[:city]
    )
  end

  def add_member_role
    @user.roles.create if @user.roles.empty?
  end

  def send_welcome_message
    UserNotifierMailer.welcome_message(@user.id).deliver if @user.email.present?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_subscription
    @admin_subscription = Admin::Subscription.find(params[:id])
  end

  def subscription_params
    @subscription_params ||= admin_subscription_params.dup
    @subscription_params.delete :subscription_id
    @subscription_params
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_subscription_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :subscribe_to_news,
      :subscription_id,
      addresses_attributes: %i[id name address zipp_code city],
      roles_attributes: %i[permission id]
    )
  end
end
