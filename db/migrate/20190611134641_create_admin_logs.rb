class CreateAdminLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_logs do |t|
      t.string :title
      t.string :log_type
      t.hstore :info

      t.timestamps
    end
  end
end
