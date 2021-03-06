# frozen_string_literal: true

class Admin::PageColModulesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_page_col_module, only: %i[show edit update destroy]
  before_action :set_page_col, only: %i[show new create edit update destroy]

  # GET /page_col_modules
  def index
    @page_col_modules = PageColModule.all
  end

  # GET /page_col_modules/1
  def show
  end

  # GET /page_col_modules/new
  def new
    @page_col.next_page_col_module_position
    @page_col_module = @page_col.page_col_modules.new(
      position: @page_col.next_page_col_module_position,
      moduleable_type: Admin::ModuleName.first.name
    )
    @module_types = Admin::ModuleName.module_names
  end

  # GET /page_col_modules/1/edit
  def edit
  end

  # POST /page_col_modules
  def create
    @page_col_module =
      @page_col
      .page_col_modules
      .new(page_col_module_params)
    @page_col_module.moduleable_id = new_module.id
    @page_col_module.position = @page_col.next_page_col_module_position
    if @page_col_module.save!
      redirect_to edit_path
    else
      render :new
    end
  end

  # PATCH/PUT /page_col_modules/1
  def update
    if @page_col_module.update(page_col_module_params)
      redirect_to page_path
    else
      render :edit
    end
  end

  # DELETE /page_col_modules/1
  def destroy
    @page_col_module.moduleable.destroy
    @page_col_module.destroy
    redirect_to page_path
  end

  private

  # rubocop:disable Security/Eval
  # rubocop:disable Style/EvalWithLocation
  def edit_path
    moduleable =
      @page_col_module
      .moduleable
    name =
      @page_col_module
      .moduleable
      .class
      .name
      .gsub('Admin::', '')
      .underscore
    eval("edit_admin_#{name}_path(#{moduleable.id})")
  end
  # rubocop:enable Style/EvalWithLocation
  # rubocop:enable Security/Eval

  def page_path
    admin_page_path(@page_col.page)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_page_col_module
    @page_col_module = PageColModule.find(params[:id])
  end

  def set_page_col
    @page_col = PageCol.find(params[:page_col_id])
  end

  # Only allow a trusted parameter "white list" through.
  def page_col_module_params
    params
      .require(:page_col_module)
      .permit(
        :moduleable_type,
        :position,
        :access_to
      )
  end

  def new_module
    params[:page_col_module][:moduleable_type].constantize.create!
  end
end
