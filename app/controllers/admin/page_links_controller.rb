class Admin::PageLinksController < AdminController
  before_action :set_admin_page_link, only: %i[show edit update destroy]

  # GET /admin/page_links
  def index
    @admin_page_link_module = Admin::PageLinkModule.find(params[:page_link_module_id])
    @admin_page_links = Admin::PageLink.all
  end

  # GET /admin/page_links/1
  def show
  end

  # GET /admin/page_links/new
  def new
    @admin_page_link_module = Admin::PageLinkModule.find(params[:page_link_module_id])
    @admin_page_link = Admin::PageLink.new
  end

  # GET /admin/page_links/1/edit
  def edit
    @admin_page_link_module = Admin::PageLinkModule.find(params[:page_link_module_id])
  end

  # POST /admin/page_links
  def create
    ap @admin_page_link_module = Admin::PageLinkModule.first
    @admin_page_link = @admin_page_link_module.page_links.new(admin_page_link_params)

    if @admin_page_link.save
      redirect_to admin_page_url(@admin_page_link.page_link_module.page)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/page_links/1
  def update
    if @admin_page_link.update(admin_page_link_params)
      redirect_to admin_page_link_module_page_links_path(@admin_page_link.page_link_module)
    else
      render :edit
    end
  end

  # DELETE /admin/page_links/1
  def destroy
    @admin_page_link.destroy
    redirect_to admin_page_links_url, notice: 'Page link was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_page_link
      @admin_page_link = Admin::PageLink.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_page_link_params
      params
        .require(:admin_page_link)
        .permit(
          :name,
          :position,
          :page_id,
          :background_color,
          :color,
          :page_link_module_id
        )
    end
end
