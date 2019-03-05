class Admin::NewslettersController < AdminController
  before_action :set_admin_newsletter, only: [:show, :edit, :update, :destroy]

  # GET /admin/newsletters
  def index
    @admin_newsletters = Admin::Newsletter.all
  end

  # GET /admin/newsletters/1
  def show
    @user = current_user
    render layout: 'newsletter_mailer'
  end

  # GET /admin/newsletters/new
  def new
    @admin_newsletter = Admin::Newsletter.new(locale: I18n.locale)
    @blog_posts = Admin::BlogPost.all_posts.first(20)
  end

  # GET /admin/newsletters/1/edit
  def edit
  end

  # POST /admin/newsletters
  def create

    # @admin_newsletter = Admin::Newsletter.new(admin_newsletter_params)
    #admin_newsletter_params.delete :blog_post_ids




    @admin_newsletter = Admin::Newsletter.new(params_without_blog_post_ids)
    #@admin_newsletter.newsletter_posts = newsletter_posts
    ap @admin_newsletter

    @admin_newsletter.save!
    create_newsletter_posts

    redirect_to admin_newsletters_path

    #if @admin_newsletter.save
    #  redirect_to @admin_newsletter, notice: 'Newsletter was successfully created.'
    #else
    #  render :new
    #end
  end

  def blog_post_ids
    blog_post_ids = admin_newsletter_params[:blog_post_ids]
    blog_post_ids.drop_while {|i| i.empty?}
  end

  def params_without_blog_post_ids
    @params_without_blog_post_ids ||=
      admin_newsletter_params
      .dup
    @params_without_blog_post_ids.delete :blog_post_ids
    @params_without_blog_post_ids
  end

  def create_newsletter_posts
    blog_post_ids.each do |id|
      Admin::NewsletterPost
        .create(
          admin_blog_post_id: id.to_i,
          admin_newsletter_id: @admin_newsletter.id
        )
    end
  end

  # PATCH/PUT /admin/newsletters/1
  def update
    if @admin_newsletter.update(admin_newsletter_params)
      redirect_to @admin_newsletter, notice: 'Newsletter was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/newsletters/1
  def destroy
    @admin_newsletter.destroy
    redirect_to admin_newsletters_url, notice: 'Newsletter was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_newsletter
    @admin_newsletter = Admin::Newsletter.find(params[:id])
  end

  def explore_session_params
    params[:explore_session].except(:account_id, :creator)
  end

  # Only allow a trusted parameter "white list" through.
  def admin_newsletter_params
    params
    .require(:admin_newsletter)
      .permit(
        :locale,
        :title,
        :body,
        blog_post_ids: []
      )

  end
end
