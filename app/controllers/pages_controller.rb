class PagesController < ApplicationController
  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    @admin_namespace = false
    if @page.require_subscription
      unless access_to_subscribed_content?
        session[:page_id] = @page.id
        @page = Admin::SystemSetup.subscription_page
      end
    end
  end
end
