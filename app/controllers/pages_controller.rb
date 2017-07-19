class PagesController < ApplicationController
  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    @admin_namespace = false
    store_page_in_session if @page.require_subscription
  end

  private

  # store the page in a session so we can bounce to it after sign up / login
  def store_page_in_session
    return if access_to_subscribed_content?
    session[:page_id] = @page.id
    @page = Admin::SystemSetup.subscription_page
  end
end
