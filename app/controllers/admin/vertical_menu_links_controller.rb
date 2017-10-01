class Admin::VerticalMenuLinksController < AdminController
  before_action :set_admin_vertical_menu_link, only: %i[show edit update destroy]
  before_action :set_admin_vertical_menu_content, only: %i[show new create edit update destroy]

  # GET /admin/vertical_menu_links
  def index
    @admin_vertical_menu_links =
      Admin::VerticalMenuLink.all
  end

  # GET /admin/vertical_menu_links/1
  def show
  end

  # GET /admin/vertical_menu_links/new
  def new
    @admin_vertical_menu_link =
      @admin_vertical_menu_content
      .vertical_menu_links
      .new
  end

  # GET /admin/vertical_menu_links/1/edit
  def edit
  end

  # POST /admin/vertical_menu_links
  def create
    @admin_vertical_menu_link =
      @admin_vertical_menu_content
      .vertical_menu_links.new(admin_vertical_menu_link_params)

    if @admin_vertical_menu_link.save
      redirect_to @admin_vertical_menu_content
    else
      render :new
    end
  end

  # PATCH/PUT /admin/vertical_menu_links/1
  def update
    if @admin_vertical_menu_link.update(admin_vertical_menu_link_params)
      redirect_to @admin_vertical_menu_content
    else
      render :edit
    end
  end

  # DELETE /admin/vertical_menu_links/1
  def destroy
    @admin_vertical_menu_link.destroy
    redirect_to admin_vertical_menu_links_url, notice: 'Vertical menu link was successfully destroyed.'
  end

  private

  def set_admin_vertical_menu_content
    @admin_vertical_menu_content =
      Admin::VerticalMenuContent.find(params[:vertical_menu_content_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_vertical_menu_link
    @admin_vertical_menu_link = Admin::VerticalMenuLink.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_vertical_menu_link_params
    params
      .require(:admin_vertical_menu_link)
      .permit(
        :title,
        :page_id,
        :url, :active,
        :color,
        :background_color
      )
  end
end
