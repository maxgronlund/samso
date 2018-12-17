# frozen_string_literal: true

# so the subscription module can be translated
class AddLocaleToAdminSubscriptionModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_subscription_modules, :locale, :string, default: 'en'
  end
end
