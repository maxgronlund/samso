class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users/1
  def show
    if current_user.nil?
      redirect_to new_session_path
    elsif @user.nil? || current_user != @user
      render_404
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    render_403 if current_user.nil? || current_user != @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.reset_password_token = SecureRandom.hex(32)
    @user.reset_password_sent_at = Time.zone.now
    if @user.save
      UserNotifierMailer.send_signup_email(@user.id).deliver
      redirect_to confirm_signups_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :avatar,
        :password,
        :password_confirmation
      )
    end
end
