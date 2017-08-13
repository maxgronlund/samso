class Admin::UsersController < AdminController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @selected = 'users'
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.roles.build
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(updated_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
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
