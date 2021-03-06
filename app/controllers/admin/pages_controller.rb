# frozen_string_literal: true

class Admin::PagesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_page, only: %i[show edit update destroy]
  before_action :set_selected
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.order(:title).where(locale: I18n.locale)
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
  def page_params
    params.require(:page).permit(
      :title,
      :menu_title,
      :menu_position,
      :menu_id,
      :active,
      :locale,
      :user_id,
      :footer_id,
      :body_background,
      :delete_body_background,
      :background_color,
      :cache_page,
      :category_page
    )
  end
end
