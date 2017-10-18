class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users/1
  def show
    set_menu
    @landing_page = admin_system_setup.landing_page
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
    @user.confirmation_token = SecureRandom.hex(32)
    @user.confirmation_sent_at = Time.zone.now
    if @user.save
      UserNotifierMailer.send_signup_email(@user.id).deliver
      redirect_user
    else
      render :new
    end

    # if session[:subscription_type_id]
    #   create_with_subscription
    # else
    #   create_without_subscription
    # end
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
    # User::Service.sanitize_email(sanitized_params)
    User::Service.sanitize_password(sanitized_params)
    sanitized_params
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_user_params
    params.require(:user).permit(
      :name,
      :email,
      :avatar,
      :password,
      :password_confirmation
    )
  end
end
