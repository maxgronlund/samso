# system settings
class CreateAdminSystemSetups < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_system_setups do |t|
      t.boolean :maintenance
      t.integer :landing_page_id
      t.integer :subscription_page_id
      t.string :locale
      t.string :locale_name

      t.timestamps
    end
  end
end
