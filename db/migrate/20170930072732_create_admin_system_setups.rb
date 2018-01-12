# system settings
class CreateAdminSystemSetups < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_system_setups do |t|
      t.boolean :maintenance
      t.integer :landing_page_id
      t.integer :subscription_page_id
      t.string :locale
      t.string :locale_name
      t.string :background_color, default: 'none'

      t.timestamps
    end
    add_attachment :admin_system_setups, :logo
  end

  def down
    drop_table :admin_system_setups
  end
end
