class Admin::PagesController < AdminController
  before_action :set_page, only: %i[show edit update destroy]
  before_action :set_selected
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.where(locale: I18n.locale)
  end

  # GET /pages/1
  def show
    @page = Page.find(params[:id])
    @admin_namespace = true
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  def create
    @page        = Page.new(page_params)
    @page.locale = I18n.locale
    @page.user   = current_user
    if @page.save
      redirect_to admin_page_path(@page)
    else
      render :new
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to admin_page_path(@page)
    else
      render :edit
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy
    redirect_to admin_pages_url
  end

  private

  def set_selected
    @selected = 'pages'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # rubocop:disable Style/MethodLength
  def page_params
    params.require(:page).permit(
      :title,
      :menu_title,
      :menu_position,
      :menu_id,
      :active,
      :locale,
      :user_id,
      :layout,
      :require_subscription,
      :footer_id,
      :color_row_1,
      :height_row_1,
      :row_1_background,
      :delete_row_1_background,
      :color_row_2,
      :height_row_2,
      :row_2_background,
      :delete_row_2_background,
      :color_row_3,
      :height_row_3,
      :row_3_background,
      :delete_row_3_background
    )
  end
end
