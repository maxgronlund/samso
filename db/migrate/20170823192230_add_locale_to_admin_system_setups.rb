# suport for dynamic languages
class AddLocaleToAdminSystemSetups < ActiveRecord::Migration[5.1]
  def up
    add_column :admin_system_setups, :locale, :string
    add_column :admin_system_setups, :locale_name, :string

    remove_column :admin_system_setups, :maintenance
    remove_column :admin_system_setups, :en_landing_page_id
    remove_column :admin_system_setups, :en_subscription_page_id
    remove_column :admin_system_setups, :en_post_page_id

    rename_column :admin_system_setups, :da_landing_page_id, :landing_page_id
    rename_column :admin_system_setups, :da_subscription_page_id, :subscription_page_id
    rename_column :admin_system_setups, :da_post_page_id, :post_page_id

    add_column :admin_system_setups, :welcome_page_id, :string
  end

  def down
    remove_column :admin_system_setups, :welcome_page_id

    add_column :admin_system_setups, :maintenance, :integer
    add_column :admin_system_setups, :en_landing_page_id, :integer
    add_column :admin_system_setups, :en_subscription_page_id, :integer
    add_column :admin_system_setups, :en_post_page_id, :integer

    rename_column :admin_system_setups, :landing_page_id, :da_landing_page_id
    rename_column :admin_system_setups, :subscription_page_id, :da_subscription_page_id
    rename_column :admin_system_setups, :post_page_id, :da_post_page_id

    remove_column :admin_system_setups, :locale
    remove_column :admin_system_setups, :locale_name
  end
end
