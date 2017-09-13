class PageRowModulesController < ApplicationController
  before_action :set_page_row_module, only: [:show, :edit, :update, :destroy]

  # GET /page_row_modules
  def index
    @page_row_modules = PageRowModule.all
  end

  # GET /page_row_modules/1
  def show
  end

  # GET /page_row_modules/new
  def new
    @page_row_module = PageRowModule.new
  end

  # GET /page_row_modules/1/edit
  def edit
  end

  # POST /page_row_modules
  def create
    @page_row_module = PageRowModule.new(page_row_module_params)

    if @page_row_module.save
      redirect_to @page_row_module, notice: 'Page row module was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /page_row_modules/1
  def update
    if @page_row_module.update(page_row_module_params)
      redirect_to @page_row_module, notice: 'Page row module was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /page_row_modules/1
  def destroy
    @page_row_module.destroy
    redirect_to page_row_modules_url, notice: 'Page row module was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_row_module
      @page_row_module = PageRowModule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_row_module_params
      params.require(:page_row_module).permit(:page_row_id, :moduleable_id, :moduleable_type, :slot_id, :position)
    end
end
