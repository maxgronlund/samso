# frozen_string_literal: true

# Module for new feature
class CreateAdminCalendarModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_calendar_modules do |t|
      t.string :name
      t.string :layout, default: 'month_detailed'
      t.belongs_to :admin_calendar, foreign_key: false

      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::Calendar')
      .first_or_create(
        name: 'Admin::CalendarModule',
        locale: 'admin/calendar_module.name'
      )
  end

  def down
    drop_table :admin_calendar_modules

    Admin::ModuleName
      .where(name: 'Admin::CalendarModule')
      .delete_all
  end
end
