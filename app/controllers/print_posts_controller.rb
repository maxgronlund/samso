class PrintPostsController < ApplicationController
  layout 'print'
  def show
    ap @blog_post = Admin::BlogPost.find(params[:id])
  end
end
