# frozen_string_literal: true

class Admin::MenuContentsController < AdminController
  before_action :set_admin_menu_content, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /admin/menu_contents
  def index
    @admin_menu_contents = Admin::MenuContent.all
  end

  # GET /admin/menu_contents/1
  def show
  end

  # GET /admin/menu_contents/new
  def new
    @admin_menu_content = Admin::MenuContent.new
  end

  # GET /admin/menu_contents/1/edit
  def edit
  end

  # POST /admin/menu_contents
  def create
    @admin_menu_content = Admin::MenuContent.new(admin_menu_content_params)

    if @admin_menu_content.save
      redirect_to @admin_menu_content
    else
      render :new
    end
  end

  # PATCH/PUT /admin/menu_contents/1
  def update
    if @admin_menu_content.update(admin_menu_content_params)
      redirect_to @admin_menu_content
    else
      render :edit
    end
  end

  # DELETE /admin/menu_contents/1
  def destroy
    @admin_menu_content.destroy
    redirect_to admin_menu_contents_url
  end

  private

  def set_selected
    @selected = 'menu_contents'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_menu_content
    @admin_menu_content = Admin::MenuContent.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_menu_content_params
    params.require(:admin_menu_content).permit(:name)
  end
end
