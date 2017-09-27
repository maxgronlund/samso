class BlogsController < ApplicationController
  def show
    params.permit!
    @blog_module = Admin::BlogModule.find(params[:blog_module_id])
    @page = Page.find(params[:id])
    @landing_page = landing_page
    render 'pages/show'
  end
end
