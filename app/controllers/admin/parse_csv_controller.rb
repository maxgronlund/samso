# frozen_string_literal: true

# parse imported csv file
class Admin::ParseCsvController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  def new
    @admin_csv_import = Admin::CsvImport.find(params[:csv_import_id])
    @admin_csv_import.update(imported: Time.zone.now)
    import_service.import(@admin_csv_import)
    redirect_to @admin_csv_import
  end

  private

  def import_service
    @import_service ||=
      Admin::CsvImport::Service.new(current_user)
  end
end
