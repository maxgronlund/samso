class Admin::VerticalMenuContentsController < AdminController
  before_action :set_admin_vertical_menu_content, only: %i[show edit update destroy]

  # GET /admin/vertical_menu_contents
  def index
    @admin_vertical_menu_contents = Admin::VerticalMenuContent.all
  end

  # GET /admin/vertical_menu_contents/1
  def show
  end

  # GET /admin/vertical_menu_contents/new
  def new
    @admin_vertical_menu_content = Admin::VerticalMenuContent.new
  end

  # GET /admin/vertical_menu_contents/1/edit
  def edit
  end

  # POST /admin/vertical_menu_contents
  def create
    @admin_vertical_menu_content = Admin::VerticalMenuContent.new(admin_vertical_menu_content_params)

    if @admin_vertical_menu_content.save
      redirect_to @admin_vertical_menu_content
    else
      render :new
    end
  end

  # PATCH/PUT /admin/vertical_menu_contents/1
  def update
    if @admin_vertical_menu_content.update(admin_vertical_menu_content_params)
      redirect_to @admin_vertical_menu_content
    else
      render :edit
    end
  end

  # DELETE /admin/vertical_menu_contents/1
  def destroy
    @admin_vertical_menu_content.destroy
    redirect_to admin_vertical_menu_contents_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_vertical_menu_content
    @admin_vertical_menu_content = Admin::VerticalMenuContent.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_vertical_menu_content_params
    params.require(:admin_vertical_menu_content).permit(:name)
  end
end
