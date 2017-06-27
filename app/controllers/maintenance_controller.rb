class MaintenanceController < ApplicationController
  def index
    @content0 = Admin::SystemSetup.maintenance_content(0)
    @content1 = Admin::SystemSetup.maintenance_content(1)
    @content2 = Admin::SystemSetup.maintenance_content(2)
    @content3 = Admin::SystemSetup.maintenance_content(3)
  end
end
