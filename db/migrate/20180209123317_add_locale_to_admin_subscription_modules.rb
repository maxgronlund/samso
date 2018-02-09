class AddLocaleToAdminSubscriptionModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscription_modules, :locale, :string, default: 'en'
  end
end
