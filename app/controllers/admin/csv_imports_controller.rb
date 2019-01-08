# frozen_string_literal: true

class Admin::CsvImportsController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_csv_import, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /admin/csv_imports
  def index
    @admin_csv_imports = Admin::CsvImport.all
  end

  # GET /admin/csv_imports/1
  def show
  end

  # GET /admin/csv_imports/new
  def new
    @admin_csv_import = Admin::CsvImport.new
  end

  # GET /admin/csv_imports/1/edit
  def edit
  end

  # POST /admin/csv_imports
  def create
    @admin_csv_import = Admin::CsvImport.new(admin_csv_import_params)

    if @admin_csv_import.save
      redirect_to admin_csv_imports_url
    else
      render :new
    end
  end

  # PATCH/PUT /admin/csv_imports/1
  def update
    if @admin_csv_import.update(admin_csv_import_params)
      redirect_to @admin_csv_import
    else
      render :edit
    end
  end

  # DELETE /admin/csv_imports/1
  def destroy
    @admin_csv_import.destroy
    redirect_to admin_csv_imports_url
  end

  private

  def set_selected
    @selected = 'csv_imports'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_csv_import
    @admin_csv_import = Admin::CsvImport.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_csv_import_params
    params.require(:admin_csv_import).permit(:csv_file, :name, :import_type, :comments, :summary)
  end
end
