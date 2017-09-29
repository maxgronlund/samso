class AddMessageWhenExpiredToSubscriptionModuless < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscription_modules, :expired_title, :string
    add_column :admin_subscription_modules, :expired_body, :text
    rename_column :admin_subscription_modules, :name, :title
  end
end
