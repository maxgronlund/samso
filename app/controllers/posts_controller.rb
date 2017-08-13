class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /admin/posts/1
  # def show
  #   @page = Admin::SystemSetup.post_page
  # end

  # GET /admin/posts/new
  def new
    @blog = Admin::BlogModule.find(params[:blog_id])
    @page = @blog.page
    @post = Admin::BlogPost.new
  end

  # GET /admin/posts/1/edit
  def edit
    @post = Admin::BlogPost.find(params[:id])
    @page = @post.page
  end

  # POST /admin/posts
  def create
    @blog = Admin::BlogModule.find(params[:blog_id])
    @page = @blog.page
    @post = @blog.posts.new(post_params)
    if @post.save
      redirect_to page_path(@page)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    if @post.update(post_params)
      redirect_to page_path(@post.page)
    else
      format.html { render :edit }
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:admin_blog_post).permit(:title, :body, :position, :image, :teaser)
  end
end
