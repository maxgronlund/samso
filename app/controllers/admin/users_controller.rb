class Admin::UsersController < AdminController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /users
  # rubocop:disable Metrics/AbcSize
  def index
    @users =
      if params[:search] && !params[:search].empty?
        User.search_by_name_or_emai(params[:search]).order(:name).page params[:page]
      else
        User.order(:name).page params[:page]
      end
    @selected = 'users'
    @user_count = User.count
  end
  # rubocop:enable Metrics/AbcSize

  # GET /admin/users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.roles.build
  end

  # GET /admin/users/1/edit
  def edit
    @user.password = nil
    @user.email = nil if @user.fake_email?
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      redirect_to admin_users_path
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
    User::Service.sanitize_email(sanitized_params)
    User::Service.sanitize_password(sanitized_params)
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
      :free_subscription,
      :signature,
      roles_attributes: %i[permission id]
    )
  end
end
