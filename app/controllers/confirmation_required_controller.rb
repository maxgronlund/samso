class ConfirmationRequiredController < ApplicationController
  def show
  	@user = User.find_by(confirmation_token: params[:id])
  end

  def update
  	params.permit!
  	user = User.find_by(confirmation_token: params[:id])
  	UserNotifierMailer.send_signup_email(user.id).deliver
  	redirect_to confirmation_sent_path(user.confirmation_token)
  end
end
