class Admin::PageModulesController < AdminController
  before_action :set_page_module, only: [:show, :edit, :update, :destroy]
  before_action :new_page_with_page_module, only: [:create]

  # GET /page_modules
  # GET /page_modules.json
  # def index
  #   @page_modules = PageModule.all
  # end
  #
  # # GET /page_modules/1
  # # GET /page_modules/1.json
  # def show
  # end

  # GET /page_modules/new
  def new
    @page = Page.find(params[:page_id])
    @page_module =
      @page.page_modules.new(
        slot_id: params[:slot_id]
      )
  end

  # GET /page_modules/1/edit
  def edit
  end

  # POST /page_modules
  # POST /page_modules.json
  def create
    if @page_module.save!
      redirect_to edit_moduleable_path
    else
      render :new
    end
  end

  def new_page_with_page_module
    @page        = Page.find(params[:page_id])
    @page_module = @page.page_modules.new(params_with_module)
  end

  # PATCH/PUT /page_modules/1
  # PATCH/PUT /page_modules/1.json
  # def update
  #   respond_to do |format|
  #     if @page_module.update(page_module_params)
  #       format.html { redirect_to moduleable_path, notice: 'Page module was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @page_module }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @page_module.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /page_modules/1
  # DELETE /page_modules/1.json
  def destroy
    @page = Page.find(params[:page_id])
    @page_module.destroy
    respond_to do |format|
      format.html { redirect_to admin_page_path(@page) }
      format.json { head :no_content }
    end
  end

  private

  def edit_moduleable_path
    case @page_module.moduleable_type
    when 'TextModule'
      edit_admin_page_text_module_path(@page, @page_module.moduleable_id)
    when 'Admin::CarouselModule'
      admin_page_carousel_module_path(@page, @page_module.moduleable_id)
    end
  end

  def destroy_moduleable
    case @page_module.moduleable_type
    when 'TextModule'
      TextModule.find(@page_module.moduleable_id).destroy
    end
  end

  def params_with_module
    create_moduleable
    page_module_params_copy = page_module_params.dup
    page_module_params_copy[:moduleable_type] = @moduleable.class.name
    page_module_params_copy[:moduleable_id]   = @moduleable.id
    page_module_params_copy
  end

  def create_moduleable
    case page_module_params[:moduleable_type]
    when 'TextModule'
      @moduleable = TextModule.create
    when 'Admin::CarouselModule'
      ap @moduleable = Admin::CarouselModule.create
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_page_module
    @page_module = PageModule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_module_params
    params.require(:page_module).permit(
      :page_id,
      :moduleable_id,
      :moduleable_type,
      :slot_id,
      :position
    )
  end
end
