class PagesController < ApplicationController

  # GET /pages/1
  def show
    @page            = Page.find(params[:id])
    @footer          = @page.footer
    @admin_namespace = false
    set_post if post_page?
    store_page_in_session if @page.require_subscription
  end

  private

  def post_page?
    Admin::SystemSetup.post_page == @page
  end

  def set_post
    @post = Admin::BlogPost.find_by(id: params[:post_id])
    session[:post_id] = @post.id if @post
  end

  # store the page in a session so we can bounce to it after sign up / login
  def store_page_in_session
    return if access_to_subscribed_content?
    session[:page_id] = @page.id
    session[:post_id] = @post.id if @post
    @page = Admin::SystemSetup.subscription_page
  end

end
