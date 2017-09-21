class Admin::PageRowsController < AdminController
  before_action :set_page_row, only: %i[show edit update destroy]
  before_action :set_page, only: %i[new edit update destroy]

  # GET /page_rows
  def index
    @page_rows = PageRow.all
  end

  # GET /page_rows/1
  def show
  end

  # GET /page_rows/new
  def new
    @page_row =
      @page
      .page_rows
      .new(
        preset: '12',
        layout: 'row',
        position: @page.page_rows_count * 10
      )
  end

  # GET /page_rows/1/edit
  def edit
    @page_row
  end

  # POST /page_rows
  def create
    @page_row = PageRow.new(page_row_params)
    if @page_row.save
      page_row_service = PageRow::Service.new(@page_row)
      page_row_service.create_page_cols(page_row_params[:preset])
      redirect_to admin_page_path(@page_row.page)
    else
      render :new
    end
  end

  # PATCH/PUT /page_rows/1
  def update
    if @page_row.update(page_row_params)
      redirect_to admin_page_url(@page)
    else
      render :edit
    end
  end

  # DELETE /page_rows/1
  def destroy
    @page_row.destroy
    redirect_to admin_page_url(@page)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page_row
    @page_row = PageRow.find(params[:id])
  end

  def set_page
    @page = Page.find(params[:page_id])
  end

  # Only allow a trusted parameter "white list" through.
  def page_row_params
    params
      .require(:page_row)
      .permit(
        :page_id,
        :layout,
        :preset,
        :nr_cols,
        :background_color,
        :padding_top,
        :padding_bottom,
        :position,
        :background_image,
        :delete_background_image
      )
  end
end
