class Admin::SendNewslettersController < ApplicationController
  def update
    params.permit!
    ap params
    newsletter = Admin::Newsletter.find(params[:id])
    newsletter.in_sending_queue!
    redirect_to admin_newsletters_path
  end
end
