# rubocop:disable Metrics/ClassLength
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users/1
  def show
    set_menu
    @landing_page = admin_system_setup.landing_page
    if current_user.nil?
      redirect_to new_session_path
    elsif @user.nil?
      render_404
    elsif current_user.can_access?(@user)
      @subscriptions = @user.subscriptions
    else
      render_404
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @user.addresses = [Address.new] if add_sbscription_address?
    session[:subscription_type_id] = params[:subscription_type_id]
  end

  def edit_user?
    administrator? || @user == current_user
  end

  # GET /users/1/edit
  def edit
    @user.addresses.build if @user.addresses.blank?
    @user.password = nil
    @user.email = nil if @user.fake_email?
    @user.update_subscription_address = true
    render_403 unless current_user.can_access?(@user)
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @user = User.new(user_params)
    # @user.validate_address = session[:subscription_type_id].present?
    @user.confirmation_token = SecureRandom.hex(32)
    @user.confirmation_sent_at = Time.zone.now
    @user.user_id = Admin::Subscription.new_subscription_id
    if @user.save
      User::Service.new(@user).update_login_stats(request)
      # session.delete :subscription_type_id
      @user.roles.create(permission: 'member')
      UserNotifierMailer.send_signup_email(@user.id).deliver
      redirect_user
    else
      render :new
    end
  end
  # rubocop:enable Metrics/AbcSize

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      update_subscription_address if Check.checked?(user_params[:update_subscription_address])
      redirect_to @user
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def update_subscription_address
    return unless @user.valid_subscriber?

    subscription = @user.valid_subscriptions.last
    subscription.copy_from_address(@user.address)
  end

  def redirect_user
    if session[:subscription_type_id]
      initialize_user
      redirect_to(
        new_user_payment_path(
          user_id: @user.id,
          subscription_type_id: session[:subscription_type_id]
        )
      )
    else
      redirect_to confirm_signups_path
    end
  end

  def initialize_user
    User::Service.new(@user).initialize_user
    session[:user_id] = @user.id
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    sanitized_params = permitted_user_params.dup
    User::Service.titleize_name(sanitized_params)
    User::Service.sanitize_password(sanitized_params)
    User::Service.sanitize_email(sanitized_params[:email])
    User::Service.set_address_name(sanitized_params)
    copy_fake_email(sanitized_params)
    sanitized_params
  end

  def copy_fake_email(sanitized_params)
    return unless sanitized_params[:email] == ''
    return if @user.nil?
    return unless @user.fake_email?

    sanitized_params[:email] = @user.email
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_user_params
    params.require(:user).permit(
      :name,
      :email,
      :avatar,
      :password,
      :password_confirmation,
      :delete_avatar,
      :signature,
      :update_subscription_address,
      :subscribe_to_news,
      addresses_attributes: %i[id name address zipp_code city]
    )
  end

  def add_sbscription_address?
    subscription_type.present? && subscription_type.print_version
  end

  def subscription_type
    @subscription_type ||=
      Admin::SubscriptionType
      .find_by(id: params[:subscription_type_id])
  end
end
# rubocop:enable Metrics/ClassLength
