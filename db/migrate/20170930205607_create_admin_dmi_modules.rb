# show wheter forecast
class CreateAdminDmiModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_dmi_modules do |t|
      t.string :forecast_duration, default: 'days_two_forecast'

      t.timestamps
    end
    add_module_name
  end

  def down
    drop_table :admin_dmi_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::DmiModule', locale: 'admin/dmi_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::DmiModule')
    module_name.delete unless module_name.nil?
  end
end
