class ResetPasswordController < ApplicationController
  def index
    @password_resend_message = resend_password_params[:password_resend]
  end

  def create
    message = 'password is on its way'
    redirect_to reset_password_index_path(password_resend: message)
  end

  def resend_password_params
    params.permit!
  end
end
