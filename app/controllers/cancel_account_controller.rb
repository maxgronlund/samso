class CancelAccountController < ApplicationController
  def show
    setup_cancel_account_view
  end

  def destroy
    if permitted_user_params[:cancel_account_token].nil? || permitted_user_params[:cancel_account_token].empty?
      @user.errors[:cancel_account_token] << 'Koden kan ikke være tom'
      setup_cancel_account_view
      render :show
    elsif permitted_user_params[:cancel_account_token] == session[:cancel_account_token]
      session.delete(:user_id)
      session.delete(:cancel_account_token)
      current_user.destroy
      redirect_to root_path
    elsif
      @user.errors[:cancel_account_token] << 'Koden er ikke korekt'
      setup_cancel_account_view
      render :show
    end
  end

  private

  def permitted_user_params
    params.require(:user).permit(
      :cancel_account_token
    )
  end

  def setup_cancel_account_view
    @user = User.find(params[:id])
    session[:cancel_account_token] = cancel_account_token
    cancel_account_message
  end

  def cancel_account_message
    @cancel_account_message =
      Admin::SystemMessage.cancel_account_message
      .body
      .gsub('{{CANCEL_ACCOUNT_TOKEN}}', cancel_account_token)
  end

  def cancel_account_token
    @cancel_account_token ||=
      (0...4).map { ('A'..'Z').to_a[rand(26)] }.join
   end
end
