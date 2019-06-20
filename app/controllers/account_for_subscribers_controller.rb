class AccountForSubscribersController < ApplicationController
  def new
    @user = User.new
    @user.subscription_id = '123'
  end

  def create
    subscription =
      Admin::Subscription
      .find(permitted_user_params[:subscription_id])

    if subscription.present?
      @user = subscription.user
      if update_user_account!
      else
        login('Der findes allerede en konto med den angivne email')
      end
    else
      @user = User.new(email: permitted_user_params[:email])
      render_new('Kontroler venligst abonnement nummert')
    end
  end

  def update_user_account!
    return false unless @user.fake_email?

    if @user.update(user_params)
      login('Din konto er klar og du kan nu logge ind')
    else
      @user.errors[:email] << 'Email skal udfyldes'
      render_new('Kontroler venligst email og password')
    end
  end

  def render_new(message)
    # @user = User.new(user_params)
    flash[:alert] = message
    # @subscription_id = permitted_user_params[:subscription_id]
    render :new
  end

  def login(message)
    flash.now.alert = message
    session[:user_id] = @user.id
    cookies[:auth_token] = @user.auth_token
    redirect_to @user.editor? ? admin_index_path : default_path(root_url)
    #redirect_to new_session_path
  end

  def show
  end

  private

  def user_params
    @user_params ||= permitted_user_params.dup
    @user_params.delete :subscription_id
    @user_params[:confirmed_at] = Time.zone.now
    @user_params
  end

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
      :subscription_id
    )
  end
end
