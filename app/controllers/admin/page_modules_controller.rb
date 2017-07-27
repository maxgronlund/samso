class Admin::PageModulesController < AdminController
  before_action :set_page_module, only: [:show, :edit, :update, :destroy]
  before_action :new_page_with_page_module, only: [:create]

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

  # DELETE /page_modules/1
  # DELETE /page_modules/1.json
  def destroy
    destroy_moduleable
    @page = Page.find(params[:page_id])
    @page_module.destroy
    redirect_to admin_page_path(@page)
  end

  private

  def edit_moduleable_path
    case @page_module.moduleable_type
    when 'TextModule'
      edit_admin_page_text_module_path(@page, @page_module.moduleable_id)
    when 'Admin::CarouselModule'
      edit_admin_page_carousel_module_path(@page, @page_module.moduleable_id)
    when 'Admin::SubscriptionModule'
      edit_admin_page_subscription_module_path(@page, @page_module.moduleable_id)
    when 'Admin::BlogModule'
      edit_admin_page_blog_module_path(@page, @page_module.moduleable_id)
    when 'Admin::PostModule'
      edit_admin_page_post_module_path(@page, @page_module.moduleable_id)
    when 'Admin::DmiModule'
      edit_admin_page_dmi_module_path(@page, @page_module.moduleable_id)
    when 'Admin::GalleryModule'
      edit_admin_page_gallery_module_path(@page, @page_module.moduleable_id)
    end
  end

  def destroy_moduleable
    case @page_module.moduleable_type
    when 'TextModule'
      TextModule.find(@page_module.moduleable_id).destroy
    when 'Admin::CarouselModule'
      Admin::CarouselModule.find(@page_module.moduleable_id).destroy
    when 'Admin::SubscriptionModule'
      Admin::SubscriptionModule.find(@page_module.moduleable_id).destroy
    when 'Admin::BlogModule'
      Admin::BlogModule.find(@page_module.moduleable_id).destroy
    when 'Admin::PostModule'
      Admin::PostModule.find(@page_module.moduleable_id).destroy
    when 'Admin::DmiModule'
      Admin::DmiModule.find(@page_module.moduleable_id).destroy
    when 'Admin::GalleryModule'
      Admin::GalleryModule.find(@page_module.moduleable_id).destroy
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
      @moduleable = Admin::CarouselModule.create
    when 'Admin::SubscriptionModule'
      @moduleable = Admin::SubscriptionModule.create
    when 'Admin::BlogModule'
      @moduleable = Admin::BlogModule.create
    when 'Admin::PostModule'
      @moduleable = Admin::PostModule.create
    when 'Admin::DmiModule'
      @moduleable = Admin::DmiModule.create
    when 'Admin::GalleryModule'
      @moduleable = Admin::GalleryModule.create
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
