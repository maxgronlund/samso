class PrintPostsController < ApplicationController
  layout 'print'
  def show
    @blog_post = Admin::BlogPost.find(params[:id])
    @printed_ads = Admin::PrintedAd.for_print
    @admin_system_setup = admin_system_setup
  end
end
