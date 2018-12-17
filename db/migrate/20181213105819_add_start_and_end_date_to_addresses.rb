class AddStartAndEndDateToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :start_date, :date
    add_column :addresses, :end_date, :date
  end
end
