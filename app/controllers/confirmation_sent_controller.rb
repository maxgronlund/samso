class ConfirmationSentController < ApplicationController
  def show
  	@user = User.find_by(confirmation_token: params[:id])
  end
end
