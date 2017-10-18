class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /admin/posts/1
  def show
    @blog_post = Admin::BlogPost.find(params[:id])
    @blog_module = Admin::BlogModule.find(params[:blog_id])
    @page = @blog_module.show_on_page
    if @page.nil?
      render_404
      return
    end
    @landing_page = landing_page
    # confirm_page
    render 'pages/show'
  end

  def confirm_page
    return unless @page.require_subscription
    return if current_user && current_user.access_to_subscribed_content?
    store_page_in_session
    @page = admin_system_setup.subscription_page
  end

  # GET /admin/posts/new
  def new
    @blog_module = Admin::BlogModule.find(params[:blog_id])
    @blog_post =
      @blog_module
      .posts
      .new(
        end_date: Time.zone.now + 1.year
      )
  end

  # GET /admin/posts/1/edit
  def edit
    @blog_module = Admin::BlogModule.find(params[:blog_id])
    @blog_post = Admin::BlogPost.find(params[:id])
  end

  # POST /admin/posts
  def create
    @blog_module = Admin::BlogModule.find(params[:blog_id])
    @blog_post = @blog_module.posts.new(post_params)
    @blog_post.user = current_user
    if @blog_post.save!
      @blog_module.clear_page_cache
      redirect_to page_path(@blog_module.page)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    @blog_module = Admin::BlogModule.find(params[:blog_id])
    if @post.update(post_params)
      @post.clear_page_cache
      redirect_to page_path(@blog_module.page)
    else
      @blog_module = Admin::BlogModule.find(params[:blog_id])
      render :edit
    end
  end

  # DELETE /admin/posts/1
  def destroy
    page = @post.page
    @post.destroy
    redirect_to page
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Admin::BlogPost.find(params[:id])
  end

  # store the page in a session so we can bounce to it after sign up / login
  def store_page_in_session
    session[:go_to_after_signup] = blog_post_path(@blog_post.blog, @blog_post)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params
      .require(:admin_blog_post)
      .permit(
        :title,
        :body,
        :position,
        :image,
        :teaser,
        :subtitle,
        :image,
        :blog_module_id
      )
  end
end
