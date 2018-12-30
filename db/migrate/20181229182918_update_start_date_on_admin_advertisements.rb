class UpdateStartDateOnAdminAdvertisements < ActiveRecord::Migration[5.2]
  def up
    change_column :admin_advertisements, :start_date, :date
    change_column :admin_advertisements, :end_date, :date
  end

  def down
    change_column :admin_advertisements, :start_date, :datetime
    change_column :admin_advertisements, :end_date, :datetime
  end
end
