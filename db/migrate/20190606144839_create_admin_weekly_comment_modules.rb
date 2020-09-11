# Module for new feature
class CreateAdminWeeklyCommentModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_weekly_comment_modules do |t|
      t.string :name
      t.integer :articles, default: 8
      t.timestamps
    end
    Admin::ModuleName
      .where(name: 'Admin::WeeklyComment')
      .first_or_create(
        name: 'Admin::WeeklyCommentModule',
        locale: 'admin/weekly_comment_module.name'
      )
  end

  def down
    drop_table :admin_weekly_comment_modules

    Admin::ModuleName
      .where(name: 'Admin::WeeklyCommentModule')
      .delete_all
  end
end
