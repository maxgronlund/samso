class CancelNewslettersController < ApplicationController
  def edit
    @user = User.find_by(uuid: newsletter_params[:id])
    redirect_to root_path if @user.nil?
  end

  def update
    newsletter_params
    @user = User.find_by(uuid: newsletter_params[:id])
    @user.update(subscribe_to_news: false)
    redirect_to cancel_newsletters_path
  end

  def index
  end

  private

  def newsletter_params
    params
      .permit(
        :id
      )
  end
end
