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
    @subscription_id = admin_system_setup.last_subscription_id.to_i
    @user.addresses.build
  end


  def edit
  end

  def create
    @user = User.new(new_subscriber_params)
    @user.password_digest = User::Service.fake_password
    @user.email = User::Service.fake_email
    @user.uuid = SecureRandom.uuid
    @user.reset_password_token = SecureRandom.hex(32)
    @user.reset_password_sent_at = Time.zone.now
    @user.roles = [Role.new]

    @user.subscriptions = [new_subscription]
    if @user.save
      admin_system_setup
        .update(
          last_subscription_id: admin_subscription_params[:subscription_id]
        )
      # send_welcome_message
      redirect_to admin_show_subscription_id_path(@user.id)
    else
      @user.errors[:subscription_id] << 'Er brugt' if Admin::Subscription.exists?(subscription_id: admin_subscription_params[:subscription_id])
      @subscription_id = admin_system_setup.last_subscription_id.to_i
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
      subscription_id: admin_subscription_params[:subscription_id],#Admin::Subscription.new_subscription_id,
      addresses: [subscription_address]
    )
  end

  def subscription_address
    Address.new(address_params)
  end

  def address_params
    @address_params ||= admin_subscription_params[:addresses_attributes]['0']
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

  def new_subscriber_params
    @new_subscriber_params ||= admin_subscription_params.dup
    @new_subscriber_params.delete :subscription_id
    @new_subscriber_params[:confirmed_at] = Time.zone.now
    @new_subscriber_params[:name] = full_name
    @new_subscriber_params
  end

  def full_name
    [address_params[:first_name], address_params[:middle_name], address_params[:last_name]].join(' ')
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
      addresses_attributes: %i[first_name middle_name last_name street_name house_number letter floor side zipp_code city],
      roles_attributes: %i[permission id]
    )
  end
end
