class Admin::ArticlesController < AdminController
  def index
    @blog_pots = Admin::BlogPost.order(:start_date)
  end
end
