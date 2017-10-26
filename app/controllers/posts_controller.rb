class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /admin/posts/1
  # def show
  #   @blog_post = Admin::BlogPost.find(params[:id])
  #   @blog = Admin::Blog.find(params[:blog_id])
  #   @page = Page.find(params[:page_id])
  #   if @page.nil?
  #     render_404
  #     return
  #   end
  #   @landing_page = landing_page
  #   render 'pages/show'
  # end

  def show
    @page = Page.find(params[:page_id])
    @blog_post = Admin::BlogPost.find(params[:id])
    @blog = @blog_post.blog
    @landing_page = landing_page
    session[:page_id]

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
  # rubocop:disable Metrics/AbcSize
  def create
    @blog = Admin::Blog.find(params[:blog_id])
    @blog_post = @blog.posts.new(post_params)
    @blog_post.user = current_user
    if @blog_post.save!
      # @blog.clear_page_cache
      update_blog_post_count(nil, @blog_post.admin_blog_post_category_id)
      #redirect_to page_path(post_params_with_page_id[:page_id])
      redirect_to page_post_path(session[:page_id], @blog_post)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    old_category_id = @post.admin_blog_post_category_id
    @blog = @post.blog
    if @post.update(post_params)
      # @post.clear_page_cache
      update_blog_post_count(old_category_id, @post.admin_blog_post_category_id)
      #redirect_to page_path(@page_id)
      redirect_to page_path(session[:page_id])
    else
      @blog = @post.blog
      render :edit
    end
  end

  # DELETE /admin/posts/1
  def destroy
    #page = Page.find(params[:page_id])
    @post.destroy
    redirect_to page_path(session[:page_id])
  end

  private

  def update_blog_post_count(old_category_id, new_category_id)
    Admin::BlogPostCategory.update_blog_post_count(old_category_id, new_category_id)
  end

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
        :admin_blog_post_category_id,
        :start_date,
        :free_content,
        :layout,
        :delete_image,
        :featured,
        :admin_blog_post_category_id,
        :page_id
      )
  end
end
