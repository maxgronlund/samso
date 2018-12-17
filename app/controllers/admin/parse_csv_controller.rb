# frozen_string_literal: true

# parse imported csv file
class Admin::ParseCsvController < AdminController
  def new
    @admin_csv_import = Admin::CsvImport.find(params[:csv_import_id])
    import_service.import(@admin_csv_import)
    redirect_to @admin_csv_import
  end

  def import_service
    @import_service ||=
      Admin::CsvImport::Service.new(current_user)
  end
end
