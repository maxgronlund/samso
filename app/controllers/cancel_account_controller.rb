class CancelAccountController < ApplicationController
  def show
    render_403 unless current_user == User.find(params[:id])
    setup_cancel_account_view
  end

  # rubocop:disable  Metrics/AbcSize
  def destroy
    @user = User.find(params[:id])
    if permitted_user_params[:cancel_account_token].blank?
      @user.errors[:cancel_account_token] << 'Koden kan ikke være tom'
      @cancel_account_error = 'Koden kan ikke være tom'
      setup_cancel_account_view
      render :show
    elsif permitted_user_params[:cancel_account_token] == session[:cancel_account_token]
      session.delete(:user_id)
      session.delete(:cancel_account_token)
      current_user.destroy
      redirect_to root_path
    else
      @user.errors[:cancel_account_token] << 'Koden er ikke korekt'
      setup_cancel_account_view
      render :show
    end
  end
  # rubocop:enable  Metrics/AbcSize

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
      Admin::SystemMessage
      .cancel_account_message
      .body
      .gsub('{{CANCEL_ACCOUNT_TOKEN}}', cancel_account_token)
  end

  def cancel_account_token
    @cancel_account_token ||=
      (0...4).map { ('A'..'Z').to_a[rand(26)] }.join
  end
end
