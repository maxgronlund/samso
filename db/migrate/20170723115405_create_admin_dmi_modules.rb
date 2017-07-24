# Module for showing wether from DMI
class CreateAdminDmiModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_dmi_modules do |t|
      t.string :forecast_duration, default: 'days_two_forecast'

      t.timestamps
    end
  end
end
