class Admin::MenuLinksController < AdminController
  before_action :set_admin_menu_link, only: %i[show edit update destroy]
  before_action :set_admin_menu_content, only: %i[show new create edit update destroy]

  # GET /admin/menu_links
  def index
    @admin_menu_links =
      Admin::MenuLink.all
  end

  # GET /admin/menu_links/1
  def show
  end

  # GET /admin/menu_links/new
  def new
    @admin_menu_link =
      @admin_menu_content
      .menu_links
      .new
  end

  # GET /admin/menu_links/1/edit
  def edit
  end

  # POST /admin/menu_links
  def create
    @admin_menu_link =
      @admin_menu_content
      .menu_links.new(admin_menu_link_params)

    if @admin_menu_link.save
      @admin_menu_link.clear_page_cache
      redirect_to @admin_menu_content
    else
      render :new
    end
  end

  # PATCH/PUT /admin/menu_links/1
  def update
    if @admin_menu_link.update(admin_menu_link_params)
      @admin_menu_link.clear_page_cache
      redirect_to @admin_menu_content
    else
      render :edit
    end
  end

  # DELETE /admin/menu_links/1
  def destroy
    @admin_menu_link.destroy
    redirect_to admin_menu_links_url, notice: 'Menu link was successfully destroyed.'
  end

  private

  def set_admin_menu_content
    @admin_menu_content =
      Admin::MenuContent.find(params[:menu_content_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_menu_link
    @admin_menu_link = Admin::MenuLink.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_menu_link_params
    params
      .require(:admin_menu_link)
      .permit(
        :title,
        :page_id,
        :url, :active,
        :color,
        :background_color
      )
  end
end
