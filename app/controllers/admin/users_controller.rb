# frozen_string_literal: true

class Admin::UsersController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /users
  # rubocop:disable Metrics/AbcSize
  def index
    @users =
      if params[:search].present?
        User
          .search_by_name_or_email(params[:search])
          .order(:latest_online_payment)
          .page params[:page]
      else
        User
          .order(:latest_online_payment)
          .page params[:page]
      end
    @selected = 'users'
    @user_count = User.count
  end
  # rubocop:enable Metrics/AbcSize

  # GET /admin/users/1
  def show
    @subscriptions = @user.subscriptions.order(:subscription_id)
  end

  # GET /users/new
  def new
    @user = User.new
    @user.roles.build
    @user.addresses.build
  end

  # GET /admin/users/1/edit
  def edit
    @user.password = nil
    @user.email = nil if @user.fake_email?
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.uuid = SecureRandom.uuid
    # @user.validate_email = true
    if @user.save
      redirect_to admin_users_path
    else
      @user.email = @user.sanitized_email
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      if Check.checked?(user_params[:update_subscription_address])
        update_subscription_address
      end
      redirect_to default_path(admin_user_path(@user))
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url
  end

  private

  def update_subscription_address
    return unless @user.valid_subscriber?
    subscription = @user.valid_subscriptions.last
    subscription.copy_from_address(@user.primary_address)
  end

  def set_selected
    @selected = 'users'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    sanitized_params = permitted_user_params.dup
    User::Service.titleize_name(sanitized_params)
    User::Service.sanitize_password(sanitized_params)
    sanitized_params[:email] = User::Service.sanitize_email(sanitized_params[:email])
    User::Service.set_address_name(sanitized_params)
    sanitized_params
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :avatar,
      :password_confirmation,
      :delete_avatar,
      :signature,
      :update_subscription_address,
      :subscribe_to_news,
      addresses_attributes: %i[id name address zipp_code city],
      roles_attributes: %i[permission id]
    )
  end
end
