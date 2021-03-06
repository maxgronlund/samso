class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def show
    render_404 and return if @post.nil?
    @page = Page.find(params[:page_id])
    @blog_post = Admin::BlogPost.find(params[:id])
    @blog_post.shown!
    @blog = @blog_post.blog
    @landing_page = landing_page
    render 'pages/show'
  end

  # rubocop:disable Metrics/AbcSize
  def new
    @blog = Admin::Blog.find(params[:blog_id])
    @blog_post =
      @blog
      .posts
      .new(
        start_date: Time.zone.now + 2.hours,
        end_date: Time.zone.now + 1.year,
        signature: current_user.signature
      )
  end
  # rubocop:enable Metrics/AbcSize

  def edit
    @blog = Admin::Blog.find(params[:blog_id])
    @blog_post = Admin::BlogPost.find(params[:id])
  end

  def create
    @blog = Admin::Blog.find(params[:blog_id])
    @blog_post = @blog.posts.new(post_params)
    @blog_post.user = current_user
    if @blog_post.save!
      redirect_to page_post_path(session[:page_id], @blog_post)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    @blog = @post.blog
    if @post.update(post_params)
      redirect_to page_path(session[:page_id])
    else
      @blog = @post.blog
      render :edit
    end
  end

  # DELETE /admin/posts/1
  def destroy
    @post.destroy
    redirect_to page_path(session[:page_id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Admin::BlogPost.find(params[:id])
  rescue => e
    nil
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
  # rubocop:disable Metrics/MethodLength
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
        :start_date,
        :free_content,
        :layout,
        :delete_image,
        :featured,
        :page_id,
        :signature
      )
  end
  # rubocop:enable Metrics/MethodLength
end
