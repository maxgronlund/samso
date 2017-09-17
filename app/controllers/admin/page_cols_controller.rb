class Admin::PageColsController < AdminController
  before_action :set_page_col, only: %i[show edit update destroy]

  # GET /page_cols
  def index
    @page_cols = PageCol.all
  end

  # GET /page_cols/1
  def show
  end

  # GET /page_cols/new
  def new
    @page_col = PageCol.new
  end

  # GET /page_cols/1/edit
  def edit
  end

  # POST /page_cols
  def create
    @page_col = PageCol.new(page_col_params)

    if @page_col.save
      redirect_to @page_col, notice: 'Page col was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /page_cols/1
  def update
    if @page_col.update(page_col_params)
      redirect_to @page_col, notice: 'Page col was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /page_cols/1
  def destroy
    @page_col.destroy
    redirect_to page_cols_url, notice: 'Page col was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page_col
    @page_col = PageCol.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def page_col_params
    params
      .require(:page_col)
      .permit(:page_row_id, :layout)
  end
end
