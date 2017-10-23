# to be deleted
class AddLayoutToAdminCalendarModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_calendar_modules, :layout, :string, default: 'month-detailed'
  end
end
