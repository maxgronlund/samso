class PagesController < ApplicationController
  # GET /pages/1
  def show
    @page            = Page.find(params[:id])
    @landing_page    = admin_system_setup.landing_page
    @footer          = @page.footer
    @admin_namespace = false
    set_post if post_page?
    set_image if params[:gallery_image_id]
    store_page_in_session if @page.require_subscription
  end

  private

  def post_page?
    admin_system_setup.post_page_id == @page.id
  end

  def set_post
    @post = Admin::BlogPost.find_by(id: params[:post_id])
    session[:post_id] = @post.id if @post
  end

  def set_image
    @gallery_image = Admin::GalleryImage.find_by(id: params[:gallery_image_id])
  end

  # store the page in a session so we can bounce to it after sign up / login
  def store_page_in_session
    return if access_to_subscribed_content?
    session[:page_id] = @page.id
    session[:post_id] = @post.id if @post
    @page = admin_system_setup.subscription_page
  end
end
