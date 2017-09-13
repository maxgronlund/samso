class PageRowsController < ApplicationController
  before_action :set_page_row, only: [:show, :edit, :update, :destroy]

  # GET /page_rows
  def index
    @page_rows = PageRow.all
  end

  # GET /page_rows/1
  def show
  end

  # GET /page_rows/new
  def new
    @page_row = PageRow.new
  end

  # GET /page_rows/1/edit
  def edit
  end

  # POST /page_rows
  def create
    @page_row = PageRow.new(page_row_params)

    if @page_row.save
      redirect_to @page_row, notice: 'Page row was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /page_rows/1
  def update
    if @page_row.update(page_row_params)
      redirect_to @page_row, notice: 'Page row was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /page_rows/1
  def destroy
    @page_row.destroy
    redirect_to page_rows_url, notice: 'Page row was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_row
      @page_row = PageRow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_row_params
      params.require(:page_row).permit(:page_id, :name, :type)
    end
end
