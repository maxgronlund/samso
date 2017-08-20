class Admin::UsersController < AdminController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /users
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
    if @user.update(updated_params)
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :avatar,
      :password_confirmation,
      :search,
      roles_attributes: %i[permission id]
    )
  end

  def updated_params
    params_copy = user_params.dup
    if params_copy[:password].empty?
      params_copy.delete :password
      params_copy.delete :password_confirmation
    end
    params_copy
  end
end
