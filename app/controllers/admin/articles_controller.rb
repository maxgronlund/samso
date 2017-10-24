class Admin::ArticlesController < AdminController
  def index
    @blog_pots = Admin::BlogPost.all
  end
end
