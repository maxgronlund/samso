class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /admin/posts/1
  def show
    @blog_post = Admin::BlogPost.find(params[:id])
    @blog = Admin::Blog.find(params[:blog_id])
    @page = Page.find(params[:page_id])
    if @page.nil?
      render_404
      return
    end
    @landing_page = landing_page
    render 'pages/show'
  end

  # GET /admin/posts/new
  def new
    @blog = Admin::Blog.find(params[:blog_id])
    @blog_post =
      @blog
      .posts
      .new(
        end_date: Time.zone.now + 1.year
      )
  end

  # GET /admin/posts/1/edit
  def edit
    @blog = Admin::Blog.find(params[:blog_id])
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
    @blog = @post.blog
    if @post.update(post_params)
      @post.clear_page_cache
      redirect_to page_path(@page_id)
    else
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

  def post_params
    post_params_with_page_id_copy = post_params_with_page_id.dup
    @page_id = post_params_with_page_id_copy[:page_id]
    post_params_with_page_id_copy.delete :page_id
    post_params_with_page_id_copy
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params_with_page_id
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
        :blog_module_id,
        :page_id,
        :admin_blog_post_category_id,
        :start_date,
        :free_content,
        :layout,
        :delete_image
      )
  end
end
